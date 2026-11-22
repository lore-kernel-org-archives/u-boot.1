Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6796606A680
	for <u-boot@archiver.kernel.org>; Sun, 22 Nov 2026 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VBDi6rhA;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmNKj7HK
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61C8080D5C;
	Sun, 22 Nov 2026 20:51:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7uchZnpMuW7k; Sun, 22 Nov 2026 20:51:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 81D5480D44
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795380709;
	b=B1vVsQZXZc7wm+dk0ik0G1B3s+n3zyfQGkyuf2+ghWol/AWRMXvOcnIHXaMWCjmTfgJh
	 Yr1IAtAbAOh8ByPQdb6ByeJB0tfRj5Eq5oqjCR4Lr09o4dlvvMlz0f071FYJUJrdKU06G
	 A6u5SGBLNb5Nuqd8S2xlBTLbqjBrAu1ZjSaQKFdJ1Zaz4afqDcJCeMvxpuv4EZCTzFkdV
	 F3twXnwT1t5gQgYRYr5k0hdTOn7UJN9e27CTNAZ8USCthUkj/BL0mAzRtmqL6NqihBhPr
	 V5Ltj8EbLFcV5yGR7ageLxAOJ2i8r11Wo1OmJfbJENQDuq22qm5I1b24+tF+svsTTJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795380709;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iIRVyNi7htFAxQKJUoriRd88Zds1An6/WoP5zsbCZ9w=;
	b=JubtRFUTVXzUWNJoEsOchn1SxzOvB5g5aPWHc+L8TWRnWJAlvqVlAtI0DDip7Q5kE+Cx
	 PYn5U1adSqFwK4I3eGBLilFAn9sH4FZX5C3cCA9WRmWWrPGn07XUML7PDcU2kUipWmD8O
	 7Rf2s/RoqkddgT8lbXtIA4ODV6D7E8FYt9fb6gTJSwFNiQVwwiAyIiREvbSv7ofRhugcY
	 KZCke4snVmcUs/BcGv760SN1tC7jUNMM5KzfFu1xqTxAfK7oE+dE4gyVCZvLCvEdoQKRl
	 UU1onBXe3zAn8AJp93M4kt9OqGI0GS2j5N79R89vTeqohzM9H8B87d/3nCXoIrA+t1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795380709;
	bh=iIRVyNi7htFAxQKJUoriRd88Zds1An6/WoP5zsbCZ9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VBDi6rhAoUm+44gg+/06KmIWBVFuZH9k/m9ni/PkF9O0+DW+XaFFJetiDtTH8iMkO
	 Gk3GY9ipsqXFOJp4EmQWc2O2uhJkVRJWbStOzWzG0kvKfg2lBMe/4mYcgVyn0H88kB
	 XNKdSnZ1oZHzOIQvy/q9EtoiJtNyOnQ6GEqI6AXb//ELISaQrQ9Iu1G6cL8lItTliq
	 N/wIxYmw792FX8ooytu/re8cX+d3Ahnt3/RAbdw/LtteB02zhnYAfksNcrG0YW8BQx
	 Mbmcq+2qXZS29gY4er7U+uulsu+r1k0dGOczNME33k4zShylwKgQiAzqTtFWuFHs3P
	 YeXfiKDrecmyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 81D5480D44;
	Sun, 22 Nov 2026 20:51:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CE4E310
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:51:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6CBD60602
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DBCPN0-iSvyX for <u-boot@lists.u-boot-project.org>;
 Sun, 22 Nov 2026 20:51:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D0FF860601
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=BmNKj7HK
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D0FF860601
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 20:51:46 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so23935955e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 12:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795380704; x=1795985504;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iIRVyNi7htFAxQKJUoriRd88Zds1An6/WoP5zsbCZ9w=;
 b=BmNKj7HKwbgtNvFAYUC6BcS/y2oqbwItSIw7S93AoQbzLFt9hRMiUhTeL6+wlO6Az0
 oiTS0MFEXrsNIHZO7Hl+uzWMFKt0sD7iXH0RiRjnLb5diDsPPIgGSSqY8HpF0XH6wypJ
 0BwOTGf+XzHKJYSaZQaKdD8WBNiMQd1KYTUOx/0zlgGDrEzCz30qeNN0sCA2kmLMQUFb
 nSaO/WoTF7PoRrbmpW65zQqzK5kuflC1+eWH7MfsKE/q/WznsZTivO5cOruXzTVBF2jq
 tnKqRHFM/rnfIPjllVG1e4nXwGO7ZFtcAdgyKfZrdjo42dMK7tojUPaAAhGafuoZPh26
 6rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795380704; x=1795985504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iIRVyNi7htFAxQKJUoriRd88Zds1An6/WoP5zsbCZ9w=;
 b=DXFtmkzBWjySjZ7vBHJPdih4nJo3R20FTQT+yOB1EcP9GfygaBKit/2geZfdBeHVMy
 HDKpOAnyEN1lZ3DJSpF98MwPUgnwaFWv7U6F9GFK3FVTOZzm1uSXbGB8LA9ej9AIH2aR
 oUrn/N1Grhe7xa12hmCuoXwmeun873NjExxBTgJmYZUCcT5+xemf+oHJ8UsYyILPgog4
 vLX2ClnBt5YqIGumefYqRr6NnA+hWELhcTjf5hCMH7CZ3x4mLQx43b5JqqGp3CkjJ9/S
 DbCCA4SrK0cH3PBlhVlUuqmil4FpeIBwn/hdRz2TbIbjKyw/m01s42WZYpT+Y+/Y/wo7
 FqfA==
X-Forwarded-Encrypted: i=1;
 AL+hErEbKpWFTKIo0763DFaDsBn5E/asJ55ExHFJCcEzxVcpI4ECvA8G0o6K6aFAf5Yrb9/JxcIrcdQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8SGK+dKiyGg4E1ctQTBUPVqmTdmMBOAZTN4q9cGr4XzJb/Ezd5
 auyMWBUIJm0iKWTTcq1RU1lUN/wCe6UgrhBQzUNWAtXW5kW6mD4fb+zS
X-Gm-Gg: AZFdTZd+nxiriLHCxnUL6mKtmm4SwyABPnmcIMq4F6cD5QN2aAdC4JV6cMXXMeKFTYR
 dNw+juSXLy8pspC/UOWC47LIaGTY+laBYIZL6n8LhXJfELxBVq55HRp5PyKlnSCmvcGQv0+z3J0
 vV936UhXdIaPihW+zowc2azNLKwiaNUJkd/Zoo6gRgsIIoq7WyoWYi+1DsbIKonLm/5jxceqWtH
 j/cEGBnmVyVEjK04jVv0Y5PaMm+myIkLK/fKUjxg2rQj5GQMGs0zzcyalLMdohNLAzZOeSyrkQF
 F/TN76mdn0hKKw9dLRT1kYm1gkxB4dPJh8azgn6CzpycJuO/es4K3l9l8VM+NJMuSxklZof8bl2
 T1RMj7VwezUHp9lI7mHh9PO9NxZyCfVvu1m7MLFGQG7cAZUB7mmeGNhURKlayS+BM/M7dJWcG5D
 BUSuYS/+iDfFmtJpfd29QNyt6mkbHM3AXU4okz+BQhzxYXTC/qwQXStcPPK/wDZzIhIIqEsqv4b
 FsofZqWvriohNHSLAl87AW5OMAO+jEM35QCMyVYx03HhaO8447R1idhtDRqziK/6qfYW32GdhYG
 kPS+C3X1KsuS5bYrHCC+uj1cKCU8BkzSQUw=
X-Received: by 2002:a05:600c:3b98:b0:4bb:7033:c92f with SMTP id
 5b1f17b1804b1-4bb88826810mr190564435e9.11.1795380704355; 
 Sun, 22 Nov 2026 12:51:44 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906e4ce6sm130420335e9.4.2026.11.22.12.51.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 12:51:42 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>,
 Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH] usb: ehci-mx6: look up the port number with the usbphy alias
Date: Sun, 22 Nov 2026 21:51:41 +0100
Message-ID: <20261122205141.748487-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261122195302.GA432275@francesco-nb>
References: <20261122195302.GA432275@francesco-nb>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

mx6_parse_dt_addrs() takes the port number from the alias of the USB
PHY node, but looks it up with the uclass name "usb" as the stem. The
PHY nodes only have the aliases usbphy0 and usbphy1, which matched
only while fdtdec_get_alias_seq() accepted any alias starting with the
stem. Since that was fixed, the lookup returns -ENOENT and the probe
fails on i.MX6 without CONFIG_PHY, host and gadget alike.

Look the alias up with the "usbphy" stem.

Fixes: 74b14db48a8e ("fdtdec: match an alias to its stem only when the number follows it")
Reported-by: Francesco Dolcini <francesco@dolcini.it>
Closes: https://lore.kernel.org/u-boot/20261122195302.GA432275@francesco-nb/
Suggested-by: Francesco Dolcini <francesco@dolcini.it>
Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-mx6.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 25907f22612..93b0d75633f 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -609,8 +609,7 @@ static int mx6_parse_dt_addrs(struct udevice *dev)
 #if defined(CONFIG_MX6)
 	int anatop_off, ret, devnump;
 
-	ret = fdtdec_get_alias_seq(blob, dev->uclass->uc_drv->name,
-				   phy_off, &devnump);
+	ret = fdtdec_get_alias_seq(blob, "usbphy", phy_off, &devnump);
 	if (ret < 0)
 		return ret;
 	priv->portnr = devnump;
-- 
2.56.0

