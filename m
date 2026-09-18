Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E6AC982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 06:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6FC8811E9;
	Fri, 18 Sep 2026 06:36:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id buI2b_lAIpQ1; Fri, 18 Sep 2026 06:36:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3FA65811E5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789713387;
	b=TBWgQ9oAxjaIshPKhg0MWrWQs2gEOyu2GC4hkgVYC7ME1X5qKjjMNTtV+B/kdTLaegrT
	 5W1HnvFu9udZH6l7MMhTPv4g6wD1sHrwBMszPJqUtsdgY63whQCHzW5/RQEVDwv6N47F3
	 rutm/23XEeIeH40WF5rPIHacpLbj9/V8eRQFDCVu0UmlU9xerAJ3vAgOF2CjD+MUzujiX
	 I97p8Psnm8gvpvTqXYWlYUZJ7oyrm3Dyv/4PW1QG+d7wI30SasY/vfiFql6B/EV00ttPg
	 aSkgSYuPGDIsj30TDt1e4aclMUFHb3iNY7//uN1FABbwvN0KOBQd3FydwOxiJ9MXSUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789713387;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=aPdeggLA4YGHjUd5LNSux3uu+9l5l74DoyLg790Flt8=;
	b=CxoZtWZ08/6tgZ1AVLuUE2PIBB4vg5kK3RNQpTSyveTYO2rF+OYzuUzZhAzLS8AH76l9
	 /UmXYoxVjoA3Ffld7I50nOw8qQa6IuXBe8n0dDIxAfzeHkxCferOr3MXOnyPNbDwozN7T
	 d0/vkgmxTmdq5jKzmyuof6I228kOK9qED9g+wMnVxlmaDRZ3h3BACUQvplNWXRMc9+0wF
	 lxm32ZEOwD2RPGQidK5LjmyvDrHAS82A80toetSatVemQim4SGBFcQaSvwaODa/BiIzle
	 dVSqKCkiQP+cSafywjUQSGOAnKu0r95a2NwDAQGoEhh2jpN+aUF/bMu+46nEYwUff9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789713387;
	bh=aPdeggLA4YGHjUd5LNSux3uu+9l5l74DoyLg790Flt8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c9ZNHKREJjCPYebJoMezly92Uv8qNDZdn7LJ+IK43LI7mFTU/EWOWdJ7XmBnYQDi1
	 5FIybjXvWk/dno507LPRg/dsmQfc+earBYQXtCdRa1S0+/PIX6lIoY79tW5dXnkCVM
	 IRQIxkvJo5m+z69clypX3cW7mUVuhrf97Uv5rbdywDX75nNw5RQ1qwOAuCvAaPiPOg
	 9F+RSl7tB1XPzXnMjsKL0wZkNMeR9rkqbRrxfMWK30tf476YqbxVN8PedG+IXj7Gn4
	 +XyXgAPNlp3wCNN3/nGEM8qAqGzGKic5WNZH9NK81iJfvVGfHhSnPRMcTxDH+KsNWI
	 +nyGte15CwkyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3FA65811E5;
	Fri, 18 Sep 2026 06:36:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D9FF29B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EE26F60C2B
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fqQxAcp6rvub for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 06:36:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E163360C20
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789713385;
 b=oe0nNZWrJI1MPDfpHzVDafJdaSYzeTVEuZEfQdiw8ACjzDVRTlLdE8ElgZNN6MUfcf0A
 E18c+7RsiREOEtOlYeEapqKvZ0nmLqfdJmygnXMZg4LDAusK4tymo5F8zn8pwMbo7UM9C
 nUorHTSirC8iWWVG8gKAmWK/3bSDK14hnhIYO6xl4OVuUHiXx0dO/eQ4q5qDANAcHjhpf
 rOBpCXpIn5olN6CTkjEL3onQgJbR7S0JGKuLX/2kzfUD1H0kZS6zauyFLafcGjJPCQKOl
 1zcPexrzIyclqPNN1htb/aK+coS5WGJLN9zLgqKHn2GnK5QE7RVT1c3RsGhPjJ4tlCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789713385;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=aPdeggLA4YGHjUd5LNSux3uu+9l5l74DoyLg790Flt8=;
 b=BOwx/OdUkjKY9I+GvtctSkhU4aIbBYco1xu2qryI9ObhBSMC6CEt+5GWg0GkagkhuNXV
 f6Xahz+YH1dF8+jc14hNt0OsKJYk7OXQniiKij9Xpg4Y/kd5IteL85eIy33QIlY8OK59X
 kAEJ19qIr2tNhyHjpshzaWEP2pgI1aCrUN1BmNpKnIAQVrfmnA56W41OCTlBE2zHT2LQV
 2yJXK/2m1kNrxlKGubM6yIYELCI5yYx6WpIi312nCxFeHcCrEWohqlt52ppGnzbCiiYaF
 Om9H3qjzZ9CoxelCDtGYVKU3ticceCT8TgbMl/faZ+JnjmpaTfbm3E3cYdUWiVxM57w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=Da7QFy4d; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=Da7QFy4d
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E163360C20
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 06:36:24 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49e66390995so1759765e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 23:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1789713382; x=1790318182;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aPdeggLA4YGHjUd5LNSux3uu+9l5l74DoyLg790Flt8=;
 b=Da7QFy4dDot60ioGzXlKNcftKKzzK5urmFoXk2DYSA//AR/q9OLReEbF/eUkXIGZF2
 AZbpV6CvHxZLEsjk851lSB/p7y9LxwsPKyO67lIlAjoeGl5LvD0wTRIR4iMcYSubahM3
 pww2d26yptL8C+tjyCqNImvInBsEimWbTbxMKA3eLsf4oEYYDui1ATMX5/oKmkQCZ6Ix
 1ynsEs22OpUVoyf8wqb8QuogfAUsVvT/CEHawebt0kHCB6gaJqrxcCfb+JOAysiqcx06
 hP0UdPIZDUrTfa6J3LVFHCTENcCH2MrbFIw7XHmhC0f+jDomN+uWtG79X4woYnifTwe4
 PM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789713382; x=1790318182;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aPdeggLA4YGHjUd5LNSux3uu+9l5l74DoyLg790Flt8=;
 b=Uuau6+/iXCJWbJ3L4z3y9st3YecEUEvvzRUK9GDTVh834aY/CKqF9YzwV27dEimU+y
 uFe4uWZ5B7CskoBAPHsAhMZnsA/Wu0BWyRhYpncGe6kFkhl6pYsV4cFb14fudqWYtN1y
 5tosg4Ozc+NHC60XeJVYWqJnJ/KAZgwkAWp7ZkKJmUTipFD7x6n+ijx5/3u4Rkg5QSRn
 HumGVO8Hzbs0rOLjq5aqN3HwGVPy/RcN7IqXO0VGO4Aa/jMeJte9TpU+ok9p+nUCxXfF
 8Jnxtp9ju5+vs7jHSyTlEDbAlR4bFNbKNtWKVm7pppUlUS52oCrW6ho/1MdXoJua1zMk
 c4uw==
X-Gm-Message-State: AFuF++lyCPGF4+g03Yxo1VVjOWrhs8BGWNO8/xLyKIhYwwunv6Mp0EyS
 4/AQdEORdEhE3zwGYfMUVKtM9QYkoSXp8N5WCDfiIwkbJJ2n0Ltee91my0mZLas7IyM=
X-Gm-Gg: AYBFou1SABGKfmusoIvCCTGkGP06G4jZ5pXeetPcm0O0whZNryfIOvopn2Ue/u/iNmg
 AnTaMUBOHai1lXQZx0vENNtc/Y0Bv2c+81ovYzGvKcKVTMrtuMMpwgSc0mzAisTtaQ/eLHLa8HO
 n+qsD/qoPznDMk6guyjTq559W8avS6SIcNQaxAjsKmb/GObRXTHUEHWmFQ7+i0QRNiYIU6/qBKH
 +j8ikxarBz0NgVZYZdrDsD36WsMLXZ3fZEh0yBZj9AEk1NkdfLwXnS6ZBzMYr0INz4FqIczPFaQ
 GwoFciuClecB5ymTjtPJRXOl9QEXwYWxLtmYMtkh9PfcH7/g3SntCc3/RFs5KKg/EPRzDuscmvO
 pFZ+wWxZj7g36bO11TzrJykJFsHcOYU9Rjgls97n9Ysz/fzPDxx3hcDgC5rJO+6/j+OMSb8soyX
 fQRPJ7Tkvn758IWlPxxouBOzz3j7F99qOEslGmfEI/S5nVpWKaE7RU7h/kcctp585H9wd7pAKoU
 vSjg8mwQu2nzaAoYLUZOSswHp1P1xPMQaTZMdIPdJ2rgfw0sR4=
X-Received: by 2002:a05:600c:3550:b0:49e:7d74:7b7a with SMTP id
 5b1f17b1804b1-49fc56db8f3mr14540475e9.6.1789713382294; 
 Thu, 17 Sep 2026 23:36:22 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc7cba562sm17725845e9.2.2026.09.17.23.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 23:36:22 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 18 Sep 2026 10:35:47 +0400
Subject: [PATCH v2 06/10] part: name the well known logical unit device
 type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-ufs-spl-boot-wlu-v2-6-8a63e372bb6e@flipper.net>
References: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
In-Reply-To: <20260918-ufs-spl-boot-wlu-v2-0-8a63e372bb6e@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Denis Mukhin <dmukhin@ford.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=alchark@flipper.net;
 h=from:subject:message-id; bh=kbY5y9cHl9Ht37xtZS+PkHVhbxHRImTilj18XN9j9Js=;
 b=kA0DAAoWsqLYjxBZ1KUByyZiAGqs29GiSo94LgfpGsgYKcnx+xrK5BrXTBCDFfdbh1hEp5S1w
 4iRBAAWCgA5FiEEnfakPZUyDpq6SEj1sqLYjxBZ1KUFAmqs29EbFIAAAAAABAAObWFudTIsMi41
 KzEuMTIsMywyAAoJELKi2I8QWdSlWpIA/RkwKfIBM/IOhmY1lAQtKsjtnkvk/TP8WzOnC3PJHHz
 uAQDpgQ/m+tvmqiZtDsMaYnwW48xvO3Tnu43LP3iviv5xAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

A UFS boot W-LU answers INQUIRY with peripheral device type 0x1e.

Add a pretty-print string for it so that it shows up meaningfully in the
device listing.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 disk/part.c    | 3 +++
 include/part.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 0fcf3af0efbd..63cb4835b786 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -237,6 +237,9 @@ void dev_print(struct blk_desc *desc)
 	case DEV_TYPE_TAPE:
 		puts ("Tape");
 		break;
+	case DEV_TYPE_WLUN:
+		puts("Well known LU");
+		break;
 	default:
 		printf("# %02X #", desc->type & 0x1F);
 		break;
diff --git a/include/part.h b/include/part.h
index 48ed4f21f1d5..12d84052266e 100644
--- a/include/part.h
+++ b/include/part.h
@@ -54,6 +54,7 @@ struct block_drvr {
 #define DEV_TYPE_TAPE		0x01	/* Tape */
 #define DEV_TYPE_CDROM		0x05	/* CD-ROM */
 #define DEV_TYPE_OPDISK		0x07	/* optical disk */
+#define DEV_TYPE_WLUN		0x1e	/* well known logical unit */
 
 #define PART_NAME_LEN 32
 #define PART_TYPE_LEN 32

-- 
2.55.0

