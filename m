Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21648C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 07:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD46B40B93;
	Fri,  4 Sep 2026 07:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id erxV9xi1ur1n; Fri,  4 Sep 2026 07:13:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 672E140B62
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788505998;
	b=NIQ41WAdlWe21iUSxDH3qHcux4VOgud39btZg7axtJ5bsIb4/ejpdD6jmflR4yscKUsJ
	 iwJu9ZYK4A6IZL5X+iVKDlr7Gx9rQn+lXp/TvqKH5b9TZkn6xPV4tz07NT6uuJ9+xm9Fc
	 g8Y+awV7Aqc/Vx/2YmzrtsBaVTya9QuZ3XoLuZjVLT7slZ36DggJQTeEs0sd27ldB4Bf8
	 zwHIpZkbIhnuVXFKuVNVr/OIIJwa4uRaeg9P+Zzh93ND8cojbJd68J2Bwv6axn7ef9W1Z
	 EnrEI0ZYo1JxU6Ww9eYDg70ekLY7pPApLgJyoVyvtInYRQUW/DvpMfKULf7c35ZUk5g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788505998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=150ctrWzlZNoereTmonKPiDNNrWKVQUgYlOimb4imik=;
	b=ofqhFYQzRucrfYJS6aJNnvotKly8S5hjKWAEbrnEquc+uQRGzppb2gGFRnWzXw2Ty+Wj
	 i+TrCQNYvLVwwvuEvVUb4fGBAhSrQRKYujhKHa3fh210cNPM4YFjxLAUX7nnAmAF4bMSb
	 9zrrJHSPwDdLmW61iCIu0PZXhcVkIXchaIZVeKp1rDRg2LWBWhuwLwoivFWv+6jQbPVKP
	 cUJnRrXZuGaoSmaR8aq111EMGeu+/YSKOchEu2DO6cLypRgFdg0naOrad3xI5i4Vm//qV
	 PhX4B8VFWFm3ZxMuB4pSK+yOX9W50sNjPKiEKu6GnyPH/HMoW9qN09ARbBBBCS4yO0A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788505998;
	bh=150ctrWzlZNoereTmonKPiDNNrWKVQUgYlOimb4imik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LzxCgSGDgRBjBZXUzHNjyZ8u9YuAX3PTUFCV1MgUhpvTODVFeM6QHGHxUzJYqlrXL
	 Y4tfQiskAWTc5KefZ9Z9T/os/BNwBnwkFtePbx1C5BwE64W+7DcofyrIuq2aako4aS
	 zlZMnfpG8AWGebDBBljXi5aXW67I4xrq3pgY++mUvFXiwLDRwvOvoRrYh0LP4Q792h
	 Wy5x4N9XbL2D+rZc5/zbh0UX0tKwiA+AZoiQE8n6mo3sn/P7Pyrg1bB4Eh2t3BlMWl
	 6va9CEXyCsNgcLtORD1jFh0yJNbZgtu/IDQDtX6At1Y+egLk10ahV/GEEs56IZ9obo
	 woCzDkTBobntA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 672E140B62;
	Fri,  4 Sep 2026 07:13:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A7DA534E
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 998758115C
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gyVHQAZNsBtV for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 07:13:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 543D680DC0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788505994;
 b=L/soMCKpWMMEce4w8rIF98XCLeZlKFnUhzSO8TkJhHxPpw2gs0SuaqKVIomdf9Oy8EoG
 2XnzpBqayKObJcOJ+Lpj4u6iUyhgub3HFIcsrLed0qfoB0u75NYhkm6wd41pPlTJ1hZH4
 6yvvWDCEKyC8AK/fBvsLL9r7Xx6ka+bQ40GdBQKUXZNixZfGHTFYR5CyE8I7lasO33zaG
 tUGglsKImIpvJMNF6+YZPF5Q4V9uxbLB2l2Nlwhs8oyVyMQQd1iJAUsROSNeCq1kFlNZd
 EYsNyvhGt6eXDTQOW4TBOL3sTNxWq3xyZxUsR+OXpox5p1sU9jovgCgLN4QmjAJ4s3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788505994;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=150ctrWzlZNoereTmonKPiDNNrWKVQUgYlOimb4imik=;
 b=Y79bg/3QX2KwwIeGc4/BiPeicUs2J03nFPonlidjGWo56TqBoB8dpwfDihGeXfGDprIY
 70vvmaKNC686DNp/w+Z9/HuU/LeN4wcm2rRd2yGnrAfgMOjNPWMP2g9s9d4Jb1bY8WnUt
 TvTiGXVDjiq8LIc/LFmI0/68J7MidjmIzsuFaf2+N8gjYmz5S8kN3JmCKN2d6rT0EqSli
 JE8R/Ldk2TyLR/yo2NGDx1eKJO87hzNVp3e2+62pkGpLJKuc3K0h+JP3qvTEKDAbtHF8h
 COHB5/XqR58GHAkXoFjRSgYOyWe17QgPJ1D9VyaSOsJZkn6/b+DEAWOVosp5OCAkjNQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=9RsRxrQw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=9RsRxrQw
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 543D680DC0
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 07:13:14 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-482dbe4d247so357256f8f.2
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1788505992; x=1789110792;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=150ctrWzlZNoereTmonKPiDNNrWKVQUgYlOimb4imik=;
 b=9RsRxrQwrCPDQe6450RaF5DL8cMVyowZrI7b6mlZhC5aWispE8FBstFzuWV5wNGQmI
 DLy/LMUt9g1LgAvjprhjvjdeJSrZe4Exof1c7jth4Qv8ypHNHhwAR4bgtOWTy4U3aUqf
 HQJ7B8l8PhDvshjWTm33dGCt3otS1eNZnl9AwKxFw8Aeu75Sdai578hurNvqpzqlfVIz
 hJoDn6+v38yvahwzLssXvzmzTsRqR3AsmAKyuh6xaVrxmETEVtf2Uf5Z0x0tytn0KHPt
 fu3+toTwWqPN+oIyJgE9t9I92kBKSmv5rnMt8O/JkGoaAhZMBfoJAzlmqE10KdzkFON+
 bZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788505992; x=1789110792;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=150ctrWzlZNoereTmonKPiDNNrWKVQUgYlOimb4imik=;
 b=VwBukRIVWYsAZQTZGg4wqtpXY1kcJd/Yv45pnB9xGGsOiHMflpaZcQHlWEEdawrlhq
 P9DiQPDQ6w0EEHNG0TOovm2NNVm3BqUDajnYcsXIKnxtUaR0PcWUznSBQ4LqMENsVkMS
 uvxEBdOO1ZMcduhPwxM6zHaoLF90IpQL+JZOpQKwmjNE/JXvXrCLUP7lXOY62QsL//Fc
 Y6M8zsSV0A1AKUD/0+kyg6z29CbZYBX2xbmIYLXAJ+kSCkfcmignzCPz12+8RO+GJAbE
 uTaNyz5/vvYfZfWt3ZR8rldPWZo05qCDmVuum1i/KiPlxbadJVSu4SfTjL5ubsluobDr
 cRZQ==
X-Gm-Message-State: AFuF++nqDcnTJnvOhavNfWS34eW3c2+v+23+/shAYzp73QFHIpoQzGWJ
 ro0+WQRYS6TedljkQ6jvimR2kKdP1dcmfxooyqmB0+xuXQyD5ye2h8GDAARUAmp70Jg=
X-Gm-Gg: AYBFou19jWmeW4YqkkzPzxerlz8vHHW+fHdIeoV+lIVFs9hHqTShkC+q4uYAKXn0gUW
 WkLCWy9/tpPZveSbsUAZu6qnQRst9L1Fx5cBYQi2ygMgAnrT9C3JxK39l5AIlCBeydJsA2a4UXg
 AMMzFrMoWvb+3vRBn6VSw1cQbgaDfUp2EbJUjQoc1YZ64b1mhEkyStaevs9cKoMz3OklLJJqvsR
 bJkYUdVHG02wk90u9X9rwkDrIWmMNPPxfPRp3A4/ro9Hh9SAlattdXh29lbrTAnIyyLbVOcCiIS
 o9D1Hd+xyQ3fxr0eYL3CvF7hLRorRe29rIBGWWxYaETLoBXw1vTVvVPKQRPUG0NpHKlHaRFyFDT
 cuHBchVmNAXhHOjL7cVpbe4YaB5ZwQsyUTx2MGFbQEuWNJP1FE8VbeIGOyguPDRRkiAuqoVWCAD
 PvN/KuGkCy546BTEqau4XJIcxcj6m/farv5nwOWmFGa5OGn65G7VROxXdmuHwxiUcNHvOpMLQjh
 eJhDftgnTE7edBZvGVL2pos27sF/5xeIWRghdvI
X-Received: by 2002:a5d:5889:0:b0:485:8b5c:da26 with SMTP id
 ffacd0b85a97d-4858b5ce16cmr3769699f8f.11.1788505992146; 
 Fri, 04 Sep 2026 00:13:12 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae.
 [2.51.220.108]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48588394fa1sm4261923f8f.8.2026.09.04.00.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:13:11 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 04 Sep 2026 11:12:41 +0400
Subject: [PATCH 06/10] part: name the well known logical unit device type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-ufs-spl-boot-wlu-v1-6-59aeea16c4de@flipper.net>
References: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
In-Reply-To: <20260904-ufs-spl-boot-wlu-v1-0-59aeea16c4de@flipper.net>
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
 Johan Jonker <jbx6244@gmail.com>, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; i=alchark@flipper.net;
 h=from:subject:message-id; bh=jLAq4CjiXIMVQoY8QHpnBOS3H51tpwg5qJf+0v5X64Q=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNyi863161k/XjbBuOypmnZ5bdUdqz0DlkT8qW6RZrR
 D/3MTV97pjIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCqmyMZGVatVzCPX6qmeeJkwVKTU1Eqagwrl3ScbJiVwrpXJaK4Cqhi3+v2bIG
 971ZZWv7TDRNtnaTSsuWdK/fKvq0RpjNtuGVZAQ==
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
index 316a0b09a097..bd9be175f8e1 100644
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
index a9d0039a522d..a7f8ea7157c4 100644
--- a/include/part.h
+++ b/include/part.h
@@ -47,6 +47,7 @@ struct block_drvr {
 #define DEV_TYPE_TAPE		0x01	/* Tape */
 #define DEV_TYPE_CDROM		0x05	/* CD-ROM */
 #define DEV_TYPE_OPDISK		0x07	/* optical disk */
+#define DEV_TYPE_WLUN		0x1e	/* well known logical unit */
 
 #define PART_NAME_LEN 32
 #define PART_TYPE_LEN 32

-- 
2.54.0

