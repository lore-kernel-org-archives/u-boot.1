Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D08606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NfqPNP/R;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Le6D3qH9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5D5C8117B;
	Sat, 28 Nov 2026 13:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uWkD9k_0L5dI; Sat, 28 Nov 2026 13:12:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A41A80E3B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871551;
	b=DNf99Dgg5dCXTdZl36gf+CsYytZZnZdUtKFbUMRT13NDQOswu6Fw0D3nSQqEdcsZzhCH
	 jvll7Kgu4UoCkr2MEtTqaS3YbSSvOnFdbJGaEo19emRLbju1cNS0MxZ0GoJgkT06aVJQi
	 KadQeOGu0u46MzN6GEa/KXuUcEBS8hWw1IiqtQuJBCUYKnyPAJDj1zCrM9QaCdTd7CS9A
	 NJtfbip4dRmCoo9GXT7LSMA1KpJP3rY+UQKenNx1ekzgMrGdE9jHDRS9J0ZU0CKPR0zGp
	 9k8GLcKJXelSVkyWLkLozrgBvzVPE5CDf+H19cS86IgDYmpRfjn1QTHP7qIurXVlnBA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Mjds9beD7hNXw4N+7dAnHrvj+mEs383a9Pss5KSkwMw=;
	b=jmuivwyA37o6N/zzf7KRDomymezqAumL9XwDhRmx6vuG7NH1x1YYi/sljLJU22AGKlk4
	 OLD81+OxXR/2B3mGFlHpm7ZT26ycSdixcWrEEmIGHPtPhBoHckA8Gg2AK5Y+MxmzmFXTB
	 xvad8kNeI69yWyurrmM8vy83nAIOQNg6pd0vkc4sSnyo9gmPa76stZTGfkrmNvVG/Z8Sx
	 fUuiy5IQTahV42NIxBS9maHqNJF9buJeZVic6gnOAuXZtPjRH0IKo1FLmI+UjHEue/Mrn
	 ls0S0Fku6q8Pb86GPCgLNTXoD+B2LLOvtkyG/xXilf9i3mDX329CPVFw7+dccip4CGA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871551;
	bh=Mjds9beD7hNXw4N+7dAnHrvj+mEs383a9Pss5KSkwMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NfqPNP/RhUEIUp0S6gmpGRad2lj3r13lwJgaaGKiz6HSRVqWLqGe/mgdWPJyEgCCo
	 1hRvnXbLOzqgTFvNRZ/YLzVPCZXjApt9AHNyiaG1PX1nP0U8ZvSeFZxRs/nwNpXAdl
	 PAIH2SxecyIf7hHnzpSmLz5K2E+62OO3EeEuBqjtMOjHUKewscTtYD2dNdfLXUyVyc
	 sibhVxaHnJnZZ2qF3kGj7If2TL+a03D1i2CDQoeQSjSyE/QXuCJd5Q6I9ur9rCLIJe
	 F2I6Iol6dH2mOGGP3um6xbjIh90gb5JZQskRRsyoWjUy5/qNvDiOP0BhdPRkD5TQRw
	 e71P+JmV629nA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A41A80E3B;
	Sat, 28 Nov 2026 13:12:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA5503D9
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7FCC606C0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0MwynwrBq_T5 for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D7F0A60621
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=Le6D3qH9
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7F0A60621
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:09 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so69723875e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871528; x=1796476328;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Mjds9beD7hNXw4N+7dAnHrvj+mEs383a9Pss5KSkwMw=;
 b=Le6D3qH9K+uYS9tgxEch5S/uPD2mup020s6I0IKiz5Ve5mOiF0T+YZ0g23J5IOki2i
 ySiyPLGBtUfQPvfl5Yp6lJWkvr+j3S5srT9RnUCEyrTvGoNa2TC4eG9OWCbHSSVMfO/c
 0jrr6QPJ8bjPaBKk3Qhx11KJmiRR8vUXVI6Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871528; x=1796476328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mjds9beD7hNXw4N+7dAnHrvj+mEs383a9Pss5KSkwMw=;
 b=LTn5L2211R90rahQ2pRUekt1XIYbkMmcVseps5iloDS8juV9frQRPmpK6AvSLPntGa
 CgSqkk1A8oE1AWQqDmG+dx/+D0654+GsRTKsnj+qcMvoDpyx9836kkzY6+LJ2yr5KHt6
 JFugEUKu+d1tfPuhJztUGyjIwnvLWVSBfqpcdm9K8bmqv6ln8hdETmdPwIXEU+FORu2a
 wt9Mh6r/ev9+hfLoJdoea1nE4b2VUTTYTzToJsOub9RhBq6UfKnWtTOnFM6fAVGkoFXe
 WCqzBNznk9CLwwGu0VJ4xb8eTMNQ/MoCx0AuLULSixcr+oQKhpaf5Yy4/sZdV01RE9Ac
 JztA==
X-Forwarded-Encrypted: i=1;
 AL+hErGbI9pLIdMNR3Wu+WYjJxrZBHTBas8vljY1IA58BFS8fS5TNW66Qy/VKd0dlOVnrkR9ciaMUSM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8IMsoRkvpcagVPpv2OWVeGtJj/5FysP+PDdhsPL8+SHLfaGGSB
 7hNBB7zm6RJ3FVKflQY/EyMA+cR/XFF03EUsgDN6+o6RD08/6+JknoHNGXiaRol04rI=
X-Gm-Gg: AZFdTZcfHmU3ZS8W2jl5Ksz+mjNAxMcHDbKXP3F/bRymkLPBgh0VmqZ72v98PPcbbDj
 /ZkkkmSGFi3rCLl7yyjn+nUrzRkCbNmDnzKwQGg7rcxB3Rm36gkPtefagnex/c/Mo1rG0sKrzZ/
 CKB6a0BDq+stHam0rErX2YpbGrDMs409En5aSpPWMAmXm7KPaCR53OUl6TL+Yayhy8gBh9xfCTI
 W5FOlw8HnRg6pNY6tK0/eR+Jl9Nscf1IZwXskLxtI+6lD/zShhxji6MJhbQ+h09pgS7HhuJ6ZE3
 Mr+EKYItHWbdBuilosOYcWeumMtp3ImtTtNu4iFmN/jN122JJkFOXqf9H56SCRN00sfNGeymxkh
 gGeZLofK16cv1LuQ/UFdj4T1hmZFHWSGXSIMqWnSy/urxWaggb6F5KuHQETAkQrWkLMAGT3F8no
 rUuI712+iW9V915IFXfj7OUZnJAr2i6vjmgdxYh3JhKaAKWjcjcdAR3tM+dF/yOdSEA7UXwBs07
 3HpYNnTh7OPS9qXPpeXBirOHhF4DzJVVdg5m9MhdEMqB43kvB2W4oMkrWBvKtK/aJWAPOTEFk0z
 1Y0xraAUGodkMNqQJAj1rKPLf1QRAIMwGMb/m3a1yIQwLs6DWm/tJQEAYzhoVMVKyXnhDL7izQZ
 tye4zeiroW0x+ZFKdUfqyxLOx7O4s4Lh8lxhiLs3B0d+m1vxBMO/ZkbKJUJs7joqkN6a+vlz2Fw
 MhasqkiCxlsdPS1Li8XafR6VIG3Q==
X-Received: by 2002:a05:600c:5303:b0:4a2:1a:a11d with SMTP id
 5b1f17b1804b1-4bb88785d24mr546346435e9.0.1795871527801; 
 Sat, 28 Nov 2026 05:12:07 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:12:07 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 24/29] boot: extension: allow longer overlay file names
Date: Sat, 28 Nov 2026 14:10:41 +0100
Message-ID: <20261128131125.2141352-25-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The overlay file name is limited to 63 characters, which is too short
for the Linux overlays named after the base devicetree, such as:

  st/stm32mp257d-engicam-microgea-rmm-overlay-am-1280800w8tzqw-t00h.dtbo

Increase the buffer size to 128 bytes. The structure is never passed to
the OS and all its users size the overlay field with sizeof() or
strlen(), so the change is safe.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

---

(no changes since v2)

Changes in v2:
- Add Reviewed-by tag

 include/extension_board.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/extension_board.h b/include/extension_board.h
index 0b9fb99ad7dc..f72db21441da 100644
--- a/include/extension_board.h
+++ b/include/extension_board.h
@@ -62,7 +62,7 @@ struct extension {
 	char name[32];
 	char owner[32];
 	char version[32];
-	char overlay[64];
+	char overlay[128];
 	char other[32];
 };
 
-- 
2.43.0

