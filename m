Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128A010ED67D
	for <u-boot@archiver.kernel.org>; Sat, 28 Mar 2026 08:18:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C9868394E;
	Sat, 28 Mar 2026 09:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=iki.fi header.i=@iki.fi header.b="GX4L4PwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F87683C14; Sat, 28 Mar 2026 09:18:15 +0100 (CET)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20F1883642
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 09:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marko.makela@iki.fi
Received: from kehys.lan (dsl-hkibng22-54f98f-8.dhcp.inet.fi [84.249.143.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: msmakela)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4fjVkp2TQtzyw4;
 Sat, 28 Mar 2026 10:18:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
 t=1774685891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PA6EY0o1uc1tDdMfZxzIcpcbxWs41hdg6B4q2//jglE=;
 b=GX4L4PwYehiPCQDan5vQGzPQPMnlhuiYyheDQ+WJCcUT2dVREMi9BLlNvjTsJk8StFfvBT
 ha5R+jdkEvECk3O388m+a2fPyh3+JV51zsb9N5gZj78ApZZjRKqjaT3hDBe9B4ERHo517i
 aurvy07zEyIiZ/5iGW/dxyjW2dKsM2A=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774685891;
 b=Xw714Wv1RHGSpfEG8j0LlBi88VQepoyq7hAa/apkYun5i9XrhtZEQREzQK9aRSWZnhC/Gk
 lc++Q8vuiRRiqeRaANev+fUZhf0i0uTu0DtrN9nEgqQ1C3uAz1IXjz+yVuKKQV5fAKoeWU
 6/pqq1GzuPdmrmV3NYxIoOLIJvZd9dU=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=msmakela smtp.mailfrom=marko.makela@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
 s=meesny; t=1774685891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PA6EY0o1uc1tDdMfZxzIcpcbxWs41hdg6B4q2//jglE=;
 b=CTfx97UrmvUZ/ofrigWRBIf3Sca2W8FI5uxaeBk09pijDMCfwkxSCi+vsrS1BBbP/MfW/o
 F1wIszqTavv+jCLiK/jyqz0yMBggB1NO1HLhBkGAtyVBRU95ew0w+p+qSVWDoun/s3QKoO
 a8I/zurjTT1agvSqG8wIlixUVFJq7Fw=
Date: Sat, 28 Mar 2026 10:18:05 +0200
From: Marko =?iso-8859-1?B?TeRrZWzk?= <marko.makela@iki.fi>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Randolph Sapp <rs@ti.com>, Erik Welsh <Erik.Welsh@octavosystems.com>,
 Anshul Dalal <anshuld@ti.com>, bb@ti.com, nm@ti.com,
 trini@konsulko.com, afd@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] k3-am62-pocketbeagle2: add initial board support
Message-ID: <aceOvTK4JGQvET11@kehys.lan>
References: <20260317223800.776581-3-rs@ti.com>
 <DH7I5D8U3GQX.1NAV7HTPAAJ8L@ti.com>
 <CAOCHtYhr50ywU_ar6qFPYrwJeUbjE+GQC_OYO_W4Pc5A9iJ5-w@mail.gmail.com>
 <DHAEYEEVEBW7.304SKN4GDBP4B@ti.com>
 <CAOCHtYgan-p8PiuwKCPmDY=xaKvnGc+F1OZXgyDHFGg4F9NJ1Q@mail.gmail.com>
 <DHCAJ6L5XC77.9F2NK2OOEAT5@ti.com>
 <DHD3N5DPHPVI.159WWX3H4U3Q3@ti.com> <acaTPyGbaUQj7hk3@kehys.lan>
 <CAOCHtYidPpJMZeDj0KkLkuh6YYOFVAe80NMWWu5wbmV2ou+=UQ@mail.gmail.com>
 <acbXV--BvxNuZxEa@kehys.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acbXV--BvxNuZxEa@kehys.lan>
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

Hi Robert,

Fri, Mar 27, 2026 at 09:15:35PM +0200, Marko Mäkelä wrote:
[snip]
>Can you help me enable the USB serial console, first for u-boot and 
>subsequently for the Linux console?

I just found your reply on this topic:
https://forum.beagleboard.org/t/pocketbeagle2-with-techlab-cape-usb-to-serial/42940

So, I must wire a 3.3V UART to a JST SH 1.0 mm 3 Pin connector and plug 
it in on the opposite side of the USB-C connector.

	Marko
