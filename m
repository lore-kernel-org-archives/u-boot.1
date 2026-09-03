Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B28C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D09540B14;
	Thu,  3 Sep 2026 22:13:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2g2UY9DkDME4; Thu,  3 Sep 2026 22:13:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4F2B640B0C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473592;
	b=LgZJVn7f03X/pp1vRyggtI7KrTjaTB5+P6kOrrs0W9LVacN8o2KhfgYdStWGZKYpbvYN
	 pVlyZpl4UMBtF+MUOFYYoZtCzyB4enVXEXE1w9DOXDOeuhrGs3h7POxJ18xaSbVLvTZnR
	 eizCeUmfq7DinINwypUlGwUiU/gDDWnIZHveSK6QEY8jUFJitnukX/3EMOgePljTri+oP
	 +heqHZHT0M0Mb+3jbmvqFo23LI6vYlR1D5SHUKkxZg4DXpRSQG4I4kpGMu2yefgWZwGMc
	 u7oIm6ta/Dy1ofAcPEuf1XYt32YUiICotQgCK4AccvdJU8sdrzuv0taQayP4pS/28aw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473592;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=TFKXoUT5zxIYqBCfOaZRH7sw0SRay804GXsXcoClhAs=;
	b=hnSG4Orfavu8rzhTEUAGiDK4CHk4IGXJWg2KDP+4iOw6trAbPYwQsTBp4HwCpk37SuO3
	 EjgayN10EHM221euEG0VvAE/mMRuInJ2f4XnX05xlJgb8njDe6atmybiBtSUMRoUGER3r
	 AeyzTirwvwdSR8yDtIBMvq4K7W4Px40iKLyPtCFMhScncqoDQ/M1OCzLmNH2hEBfT79fh
	 dHLhrUp3Md6t4+r7wCBgRvN4zV6eZOlbAig/iMaCXmfbMxABBFIQ4CVfm+8KOZoOKIAje
	 Zda4ZeWYs6M23RLE9dd7QfJQF52UyXWXSK0rzgueMVcL8EkU838MovDCX5DLghek3Bg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473592;
	bh=TFKXoUT5zxIYqBCfOaZRH7sw0SRay804GXsXcoClhAs=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iQeaPiOqVzu95wSF0hMNQNUbK3oV0QG0vxjlQoAvoepxQ3IsBTPIhyiI5L/77wyLl
	 w+DpGAeROsyCte6s23bnmeJlTRicMZKxI9rgl+K5C98k37mzIpxPwgE6HId/ZTNnpu
	 J/9hbtcaypdYw0juMIR4MQm7XiHxhQHYEwgh7YHXDPUi9kRsdT124Jjez/1Z2s0s92
	 uWOcQDNQxSiPgiT70OjMt0HkD0Ecjm5M8tkomODVMvvKsLWgbmLuXq9q2PBuzQHktz
	 pr0YsNBQYLNV8kQ1z8yDoFktIGbj6NrC0+D8LwBeMLapT0QmoDH47yqaO52/vRlXRO
	 o48o9FqschJVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F2B640B0C;
	Thu,  3 Sep 2026 22:13:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CDAF2FE
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8249C80EFB
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vlSBvYk1PcNs for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:37:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E1E1680F05
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471458;
 b=oYrsrVzAKX/beuzZtralPiZ6x0fAaS6q0fkI6wnKbTHsNLyV8MEkSvCvVSNYesOcVEJF
 VD48LRlFWgzKq1S4nnqJ86uk3eayET9L21u1CHoVHMsIqASLtJDW6HndxpXDA8oQZ3PUU
 +caCtYCQ+BdXLTI/grRwzxl1TN1X2wn/iGNi7Wyw0TmIQ3lBeH6Nmrfocvzh+GitFwip6
 x31Dm2srzE3LE9L4csaktwxV5zP56GAgDpSDRwbGXjxU5sLgRS28WPPV98mwf9QgUtSuf
 SfLo3qBzQ7SixZQVzFLTKsZ5DPXi50DzsRGJJriEBcvsAspkifweG81zp/MdqUa+scA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471458;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=TFKXoUT5zxIYqBCfOaZRH7sw0SRay804GXsXcoClhAs=;
 b=dxFo3yRM30sGKQjloZIt6atVDdJjjazxQCQh4o/aZtNi+MvYQPIrEiowhEJR8cMlmDxT
 s0nZUDOLQqOCFyPZR8PBMusBkI1VI2MnGap18cnjfRCsL6n6Nen6LoA33TfSvIQZ3plR9
 3qFM7sJfAsbZuwXF7vvDGAsNVD3eWBRtqmBU04a2/uVOZUciNp9lTIW+Y+5E1WWVNMF0I
 Ijrm6UhsWWBYZa8iBj8AyJl3oY7qUe6Ucusn/PykpKH1Z9CelOJgQwSMZCLPv8id/Egj2
 pASprwsznv0gKlTij/C3LgdwJfO2dl95VvZ0HnGRtcAWamQhnN+NHsglnyFMUS2RRug==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JMyYeAhG; 
 arc=none smtp.remote-ip="2001:4860:4864:20::29"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JMyYeAhG
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E1E1680F05
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:37:35 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-46aef6e48fbso195670fac.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471454; x=1789076254;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TFKXoUT5zxIYqBCfOaZRH7sw0SRay804GXsXcoClhAs=;
 b=JMyYeAhGEtdy6ex4dC1hGZGP6jOW7qPsB6Do+YoR23eDUfNK7DEHlRZn4wvQgvdlXV
 cNhIMW14l0NkljnF9TXguAxJMR4R6iiOtl0b6lKoEqpsaLCdiK32WKY/GPE7tnvKXRNy
 0JPIcfOhmx4BR4hxg4Cq//nQ6rXR9KsGFER/n9R76FyqI/CT1B9d5pJ4Y6jLNlvKnDf1
 c6vjON+H28Q4IXmD+hEtsaPgDHeqZYKJgAIbtZsubBj7K0N81ymlRMVUejYk7wa19INB
 wigNFmr4RvrnVeQ+XaCJnuRbBpxpPlQM9DGD6YCvqb19OH7X/48XFuOpoHnb5fQI3RZh
 feuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471454; x=1789076254;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TFKXoUT5zxIYqBCfOaZRH7sw0SRay804GXsXcoClhAs=;
 b=BAeHQcGh2RRnQiZK3M2RGZZON1/pJE4a3HffHIG2w3+FFHSBFswqrxj8dsM+VGG2+J
 dfjpOPJd2B3zP1YSN8Y1tl9XDADbNWM7jFHeaeH4hqlmI+rGlCy+W/t+fZwWob9dY90E
 D0EYJMtef5RavryvUYp3cVG4bLXNGE0SGvRPT/aarbSfMtlt8JbRlaN38pCoZB1bmdRj
 VSCvJADeyTDW0UU0jFdF0XY6UXJJ3ay/kOuURe+IpYQbUBj66kG5pah/Z+Nh+lW71e67
 yrpWAbqZGLHgWaTtKkQQw44wjNfoiu8Q/aFFIb00BMsfMOx9lSX1BZZ3JcVKxPW0FG87
 TFuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwE0VBq4WAlW/3ScuMGqY5CsElYUrC2bptbtgweA5dREwvo564srTTlPSPtaF7AOOrI5s4Sjmg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n2TEDgGe45VoGjH+IhKyevu9b/98Kr85f3z+X3XfqT1/1tZ61g
 VDuRgh73nqeRJ0kqhBkoKZH0qM9SC0kHYbYGQqQf4/pbX6hDc9r4pths8lHMWj3GDfA=
X-Gm-Gg: AYBFou0z54gmRKCxvnPMF8AyqdHT4QD52CkumZlpfbmK2Jn8KPRHEBvPQd6Ngs5x0hE
 W6k+w78b0p5DjYQeaAqWJhQTSjC2wW2Uyvum9MRjevjLV7NQYgs0BOsoJV4r8bDkxh6uAjl96E9
 gKG8DcjQRbdiuy/wbMEVSEfvmHJSB5QoCuw/ixaVwFJGhlOdFnzco8qoQqqV8XSdmBHiONMByq0
 XZmTZtzefdNzSzjaHsYuUfuXvGX+sIuBOO3V8eRRbsz93CYw6N0cHRBhj80sCYnJlk5wimSzwor
 XkLnquTHyeYLxETGvLXVpYi7vssQPm26tGTdig5mdc5J2hLaipORwXR8haE4zcUYyCYR80j6Szq
 TZ58cftMoluHeOxma9JsGzRWw599U53l2Bl9D304dpHFs0lFH9Xn1YABqn52iM/06HaGtJstRbk
 EnVYRfalZ7f2KBlenyDluvdb5dgSjw+VCElmQXXJvA0JmT0qy7il5fVzwpSncN5+8mgkb1upqV0
 gPI
X-Received: by 2002:a05:6870:330b:b0:45e:4deb:92e7 with SMTP id
 586e51a60fabf-47552a575a7mr1886279fac.10.1788471454510; 
 Thu, 03 Sep 2026 14:37:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.37.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:37:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/14] tree-wide: check dev_remap_addr() for NULL
Date: Thu, 03 Sep 2026 16:35:44 -0500
Message-Id: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CQAxA4auQrm1ScIagVzEs5qdIFUcyBWNCu
 LujLr/FexsoZ2GFc7VB5peoPFNBfaggjC5dGSUWQ0NNSyc6ojcYH+hizJjWacIwcrgrdtbXxtL
 gyFgo8Zx5kPdvfOn/1tXfOCzfG+z7B8BeSvJ6AAAA
X-Change-ID: 20260903-b4-dm-addr-null-checks-85b1450fa045
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=IzjLdT454rjLHNKCh3FZPXXKygOO3Txt6xAlNlF8Q5I=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmegzjC+AEXSpYRTzmyQvcBnaoPk0KdwSLuv9y
 /RpJdUuRx2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnoMxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AtoEIAJ+IOhrA3olaXu+GMHVf5A9cE7RDXKgnQrqBCtH
 sdmFNh/0hqbCYXD858bWvJeOt0OHgSPiery+U9b+HWCj1NNMLczb1wz2iCNgcFvGWrb3URh5zb+
 3ScSkdyoWFVUYtzhoKFH3MByDuCCnqd4n9Z2SZBHHuIwlcRfKnr2K8HyFgkOzwSXKFLbgs6L6CU
 e7ScxS/jd5UJgGr68oewme/r1dZ8fZmKYDSez/raInubEml/k9DisUk7BKrODYJ+eUUXz13DvwN
 3a5jAngfwsrWqnUVlMHh1J2DCQG3QV67Dg/i1q9ZeOb29D/hatWMRHBzcAvAXvrKgITvbV7d57T
 9qrQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:11 +0000
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

We noticed a mistake in a few MediaTek drivers where we were checking
the return value of dev_remap_addr() and friends with IS_ERR(), but it
only ever returns NULL on failure.

Then we saw that we were not the only ones who did this. So here is a
series to clean it all up at once.

The return values are a bit inconsistent, but -EINVAL seems to be the most
common, so that is what is used in places that didn't already have a
specific error code or established convention in the file itself.

There were also a few cases that used IS_ERR_OR_NULL(), which isn't a
bug like IS_ERR(), but we clean them up too for correctness.

There are some places that don't check the return value, but I didn't
look into if those should be considered bugs or not.

Custodians: feel free to pick up any patches for your subsystem. And
I can take what is left through the MediaTek tree in a few weeks.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (14):
      power: pmic: mtk-pwrap: check dev_remap_addr() for NULL
      net: mt7628-eth: check dev_remap_addr_index() for NULL
      net: airoha_eth: check dev_remap_addr_name() for NULL
      net: hifemac: check dev_remap_addr_name() for NULL
      net: hifemac_mdio: check dev_remap_addr() for NULL
      usb: dwc3-octeon-glue: check dev_remap_addr() for NULL
      usb: dwc3-am62: check dev_remap_addr_index() for NULL
      timer: mchp-pit64b: check dev_read_addr_ptr() for NULL
      phy: qcom: snps-femto-v2: check dev_read_addr_ptr() for NULL
      phy: rockchip: inno-dsidphy: check dev_read_addr_ptr() for NULL
      pinctrl: aspeed: ast2600: check dev_read_addr_ptr() for NULL
      reset: ast2500: check dev_read_addr_ptr() for NULL
      reset: ast2600: check dev_read_addr_ptr() for NULL
      arm: aspeed: ast2600: check devfdt_get_addr_ptr() for NULL

 arch/arm/mach-aspeed/ast2600/board_common.c      |  3 +--
 arch/arm/mach-aspeed/ast2600/spl.c               |  3 +--
 drivers/net/airoha_eth.c                         |  4 ++--
 drivers/net/hifemac.c                            |  2 +-
 drivers/net/hifemac_mdio.c                       |  9 ++++-----
 drivers/net/mt7628-eth.c                         | 10 +++++-----
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c        |  5 +++--
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c |  5 +++--
 drivers/pinctrl/aspeed/pinctrl_ast2600.c         |  5 ++---
 drivers/power/pmic/mtk-pwrap.c                   |  4 ++--
 drivers/reset/reset-ast2500.c                    |  4 ++--
 drivers/reset/reset-ast2600.c                    |  4 ++--
 drivers/timer/mchp-pit64b-timer.c                |  4 ++--
 drivers/usb/dwc3/dwc3-am62.c                     |  2 +-
 drivers/usb/host/dwc3-octeon-glue.c              |  5 ++---
 15 files changed, 33 insertions(+), 36 deletions(-)
---
base-commit: 1c5004ffc5e3f000eca6cada32af7c83bd925c2b
change-id: 20260903-b4-dm-addr-null-checks-85b1450fa045

Best regards,
--  
David Lechner <dlechner@baylibre.com>

