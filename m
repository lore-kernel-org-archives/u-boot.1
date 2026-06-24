Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF41CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 17:23:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8BA38460E;
	Wed, 24 Jun 2026 19:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="IGHTzLtW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B2388460E; Wed, 24 Jun 2026 19:23:40 +0200 (CEST)
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B82180398
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 19:23:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng32-54fb5f-245.dhcp.inet.fi [84.251.95.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4glpgS2Qdzz49Pxr;
 Wed, 24 Jun 2026 20:23:32 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu; 
 t=1782321812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GpvOo7qwPQsR11Lvndv417fJTUQGMlF+r5gFGbLxtv4=;
 b=IGHTzLtWIF8XtviBOWba849Y3s1GNxNJ9qOYK3mD7HJeV1O3ypvnZaun8VfOcYaoyJdu/u
 T80qMQnGwOW6SbhMdLIhv1thC7/TwWziTxXMAt2qejcpM84wcTs6CQRcE4ZmERaO9Gh+CE
 uBSl4/c76ac7RRpp2Z7NM78U1INDbOB4os8pmbbfPWYGP50IWC8QqhzJsu0edDUGsU/aPw
 52uUhtAvRLaBwTkzzlYm9F1ftar8z9f0DHvdoScJfmyXCwEfftmkaT+KI6S2YIi9ra4fAe
 oS25jr2YWizP4tQ5Qs2jEUMuHjI0bvada+EBTLUYtDziyeLHbIc1FpjyFDf1uQ==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1782321812;
 b=RJsJe1NZIccbgWtN9CtKWqsr+vXeYZYjFKXlmM2w9iRxwvlv5TM1IYFduPQrd2sDOeDDMl
 w6hDqp/iQ7vUgkQ0eEXxZRtozwSDjMjnPH5HYfMX7v06IHMpa+0pAEyKAKQy/OZ3AcNydb
 qB8K2YokX0H6bm3DoZGz8EXr0eTcASWMp733hjWHKXP463N6pz34PLr0Vzgr3xk7hjBPiB
 UFsbCku4gPKuIUdjA/V3ArX1ueT9nRzElMHGcKLphfr6hKjCtNZqA1XVh/CYQKS/eiuRbw
 z89wnFNwheePb7XYJblEpixfYVQE+hGV0/eto+/9cA5N9nlQzYlLJkTb+hKejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=lahtoruutu; t=1782321812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GpvOo7qwPQsR11Lvndv417fJTUQGMlF+r5gFGbLxtv4=;
 b=VU1XcdsKPe9qOD5xKIAJjW4fGjuRzSgVbY2IxVKn++mpbCTVEByKZM2F76hiZymKgCxFMl
 ixN5WiQq6+9kB/kIoUCCFbaysakDBJZVDJR1RblkaVsuTMWCYoKk9Y8+Wj+Gmh4+0G/QKX
 EulKhMW9AsBCmql9WakJzojkV8CFFW1504QsqgVyIyctxfq4gS7kkxe+JSWdW+x6yR+o84
 OV4/EWVEJB2Y6r9M5HLJpnXEEqKtw5V+WHoI7RBTr7+ukWuAwiC9M6dTFqW58C5PYHP3Ns
 1i7Zu+t/mVxcrFgSk/kB6IMpkokFZuzQJDguVkTp7V7OKrulLnFC7n7IwycZQA==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
Date: Wed, 24 Jun 2026 20:23:30 +0300
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org,
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com,
 trini@konsulko.com, afd@ti.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, sjg@chromium.org, u-boot@lists.denx.de
Subject: Re: [PATCHv2 0/5] k3-am62-pocketbeagle2: add board and variant support
Message-ID: <ajwSkh6Pa97LPVi5@kehys.lan>
References: <20260619231719.3823195-1-rs@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260619231719.3823195-1-rs@ti.com>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Randolph, all,

>Add initial board support for the PocketBeagle 2 from BeagleBoard.org.

Thank you, this is very small, and best of all, it works for me, on top 
of master d57ea0d9edf5e5babffd280f7352f23a33a00948 from last Sunday. I 
slightly adjusted the board_setup_dest_addr() injection in the first 
patch in order to resolve a code conflict:

@@ -356,6 +361,8 @@ static int setup_dest_addr(void)
  	gd->relocaddr = gd->ram_top;
  	debug("Ram top: %08llX\n", (unsigned long long)gd->ram_top);
  
+	if (board_setup_dest_addr()) return board_setup_dest_addr();
+
  	return arch_setup_dest_addr();
  }
  
I successfully booted this together with a version of the software ECDSA 
patch, but did not try to load a signed FIT image yet.

	Marko
