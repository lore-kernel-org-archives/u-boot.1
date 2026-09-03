Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C348C624DE
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C60854084A;
	Thu,  3 Sep 2026 22:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id okUKA9nBuccw; Thu,  3 Sep 2026 22:13:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 03E9140B85
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473626;
	b=Uz9GAWp0w/LFez2ZVqYkXM2IrZUi3GzsZPXjSyTNOzyzo95dqybGFbGLpC8Wgkk9rOjo
	 ZoHymR59ZHtF7ru83BUfFIjTZDHJlpjgV99dd14BcoresJff89ZJyK8QpXPpTux5xfeGL
	 T2OnqddH4zNaxNwHSko/gB5LRl0uYO7HsVp0F8RlxP80EG44lFBNJmPvKzE8C0GOrBy9D
	 w257i3wr9GXc6FzXhSjBHRjNXMWZS21H5xFyq0wcKR0nnmmK3mHWGPFH73/HNXtWqj7lR
	 w2WszjHzEU8LMyEj+rD18sEtMDFa6RbO9i1iTAGeHuytqr0NePaEOeM1LlQax8Tu4hA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473626;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FiiIi+OUs/BqLos2JkuvkdEo8jHsg0vyVODrOEpcCQk=;
	b=c3A412xYZH43N04iCpJjJ//HSaGdl1r1/681HPf5SxeoGiDrMenbdzmcmsPOens5GmmA
	 kWIKDtxyGFu2LfGBCFbBuA0Uvyw6QZeyoroMKqFd/Sf5QQ0WaaOK84wiV9JPprZXiUGu/
	 8FYrLLZ2Xvtd98juiUxoPFb/A4G047tNNe1epXU9xuIHBAH4RQ/R7bKakXx8MYxXKvgk3
	 U5ZI0mVVmTiKqZX2dXA6nEiHcGOjB7t1HxF0osUwEPUnLCIMQVbDw5h69p/YBuC+Sluzc
	 VjKM5gMXA3CYl/IKVj6jxV95r0gRLp8upnW6KGAfgxUBjtqq8l8WXfPtyaiHekyz7ig==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473626;
	bh=FiiIi+OUs/BqLos2JkuvkdEo8jHsg0vyVODrOEpcCQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gEMFUqfecDUKUnegdz+RT8VSixvtE4ZFus+FacpXns3uHq6lTIZ1wSlo2gZmCXx0/
	 DLPLGHhbTuisQh8g5lqG7exFLctcDDkqZWAua03Zt5+vlQryLBAt62gNbUfkSZqz5M
	 ecK2SKyhP+A6q/pLIOd5p1gcetU8WDOtaHsoFKd5Ti/4erAg44plmckuT762KPYKja
	 tCKeGP+q+TGXUiWGVPM56oPSm0YS+9cmhhaJM/2nWbBCz3rEESuEt9KikoNakcqD5T
	 KDMQjNx3uLXk0OkovPpU0ogG/fDIUgFXJsjLlj+4FkKA/n9ZbbB5SJGFacEz2XRofE
	 fJv+DBVAOsf0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03E9140B85;
	Thu,  3 Sep 2026 22:13:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0371C2FC
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E915B60B6D
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id REw_wo3rO_tN for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:38:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3086C6070F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471495;
 b=n18SY3TUsTTPNDLMfcfGm6IHsmvHCUkCdQlCWwv6pTYMGoorHKXl2FBUP8s+5/dKdfte
 faXSHqtf65o+HrDzMxMr7TpaXS82oaNF3QGDfKYm+FRCy52dKDDgLQw6zAbl/OoIeX+sQ
 ghXbJI8uv2NewD10JEvKfb+P7pUF42bX8KUktI4Ds9ZpturSmPLZ8tFPjh3+WlCf5CQ8R
 KgHQEX44dEuj9kxh280rdR9uJn/Ui4t8vVNcy1K1aJNaDvUN2xa9GWNxpHa70ASEvKX0w
 gsVzJetIVyKo0m1Si6dyQCQO5S0CkvgioOge9W0fazoZRToQfNpsfnim8DlbxAickcA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471495;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=FiiIi+OUs/BqLos2JkuvkdEo8jHsg0vyVODrOEpcCQk=;
 b=k9leTt8ia1s6HV9pgi5hIg0uW1bvDYmYKmFXWeBoHtPFMNSwKgo0Z+mpd/A1O6doLNCT
 Z1J/+4SDbH+gJyLNJ/d8dCrK8qyWcrpKzrAWBADW9dKGQvuRuHxfEEKGXXzO8U/tNTnwp
 bdJ1bJyM6vfmi9jYdiYEYd/Ig39TqTPnkIRzgc9fugZG/v2LkOI6dscbennvU8CXp9636
 ErogtbDwrasg4r8TvwBYmy7rk+9jQFwjDT6+ky6kSg7qDW+mCj4QUz9Rs1D7p23KY7wd9
 PnonQE+ATeYQbrYBMxE7pRLX84Ysb6HgPAJ8pDiAN7L04Z9T9fAY3UegSoR44hmov9Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=JZJaiD1t; 
 arc=none smtp.remote-ip="2001:4860:4864:20::36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::36; helo=mail-oa1-x36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=JZJaiD1t
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3086C6070F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:14 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-467f09c00c2so81821fac.3
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471493; x=1789076293;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FiiIi+OUs/BqLos2JkuvkdEo8jHsg0vyVODrOEpcCQk=;
 b=JZJaiD1tQmg2KEsauknsfqYkZdzjLjm2DDr4EHiZPAFZCJr5BLneG5JzqBiWoipDix
 tdnt9WEhQIPx/J3/vuU3jH+ArgztVcjZVUM++YaMaPKxqaFFS4+Ae60G2i6HtW0de+GG
 6VctP98HflhkaF6YBa/byTWzb6OgDbyoieegK0Sx+FaDyv4oyy2Fm0wOAJO3l72QSUoK
 Ucl8UkMXQ7zQ2YjVPyCjkEKcuxM22UOHGvNOT7dHpSbSWS1KkK+KY40uPyDI1AuHfHXW
 woe/lvl7c4yS3N0wtHoSnBqDQ8JUloqaxG/Oy+Elxjwu1HvHBaCrVIbtyKvefE7u0lKm
 bUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471493; x=1789076293;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FiiIi+OUs/BqLos2JkuvkdEo8jHsg0vyVODrOEpcCQk=;
 b=Q5E4fNCS7usLa34Ps7JXR96aHiUNFp7e3b2otTmiG8FWfZndxnIPBV047omFKBSuG/
 dQBCTQylomoLhA7uKGNZl8ZHexaPyNFc4Rv+M1h/UfFPkiZV8aajROK3U2k5iwTz8tHu
 IT8HXcpuVZFwLrSwXvJQ4SN24UolyExC344HPzdJ4dbo+yhi2KuWvqxLhp5A1pneQmTO
 5RnkQLOUBFDEvCEgS0IG1Ms/Jw/ToWJtCKdofyvYsHWzZIdvOE/hQe+yL1FqiPoOs2Bt
 mLwby6qFzH3HMOuofiRCFBKLX5fQI14iwKujYxBHKHb/IjIWuXyB3Jojv6HEw2co1Rri
 nl/g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaxA3GNRhEtHQkiq2Od9xp8cuozSYgJTPFoyw2gSUYZu5j5P6bi5GrfsAW7JGP2EfepxcJef8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m1kT2NHdzQQEnBzSzWnsJZXOU5tW99CZcQdCVyO92ak7AV7AgF
 1yijJPkKEPw0fL1GVBAMQNnyZDAwAGWVbihnT7LXbIlWxZNPVQ4dokHwd0a9BrylBfo=
X-Gm-Gg: AYBFou06ljiOIidqmxe3Eyf2XfVfEWMqEnLaWtN2BhEReUyWwYgQiISlYR6YqJGoEvF
 CrnHE1MQKWkK4t2syJgM+c4RqufYe1+e/S+HJA/gGTpzJZaVnk+5CJuYpzxKE2hTO5leKx9hSnU
 5dSOy6WeW/qSqDX3+CeZ+zZdmy2MdbcN+OfqYzB9TueZW6kNOOidjxG5GW8NG2jLKSAkyoVnxOo
 Jyfh2lXfXTnGTYY2SIcpjY0os9c3lSZjeZsOEHU1WdtXO11eSzmPSFGYUzu+/XFGvQjaKeR6Qzy
 0QKq6XWpsFoFdXB7Kj7CgkYsQX015wb9PcGVspG6XvIoS5ffS44ERcuZBG1k3RZy8deMAFbm59C
 c/c6NUhqVyL184uRUh5ubYAr2azLJp1ac/vw5hNc+ubtzbg7LT8xyZPmeCKD5MQs5Q1SNt9WM/b
 kBNbaPMwE6W6UjWu0uoJls90gaqNRK+XOxapphoqZCYPmnJW0izXQP7BxDmYawM5qX7Q==
X-Received: by 2002:a05:6870:b01d:b0:46a:deaf:5915 with SMTP id
 586e51a60fabf-47551591688mr1889774fac.9.1788471493601; 
 Thu, 03 Sep 2026 14:38:13 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:38:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:55 -0500
Subject: [PATCH 11/14] pinctrl: aspeed: ast2600: check dev_read_addr_ptr()
 for NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-11-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=HJ9/bhlERpGXqohtMC1U6MwFwpX0/bEfrK0aFDsy68c=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmeiAyfCvLcn6T0kuf8ZjVmlRnVstxTpSR8jyA
 2lfS+sSSsyJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnogBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASWEH/3cLzgNFNKKEaRCLtHVjinSr1wGmom5n8L52WPr
 ROCXsORvHTxnBgAgB+EaZcBHhCwPO0u5nFAQBLqdeMn2lWrXUYtYTT1B+peaTmRCNOPzsJ86+Mb
 uittXa82oCZVMQwKasIJ7IwLd8SaWEBe2MN68GSIOjCAQPLT4561nQanFLi3ZsFfjqQuJTiGbl3
 D5xZjIT+vwXllDxOj7duKf7LbRZCHELBhZU4RxHhr3fHuPBO4Z/3usDkUJ9XUpD7JTA6FZQ1gHb
 yU44p7RGNIcLbMamJhFyAFf1v46XDvz/Zz/IdqAw8Kna2YMB7flhRuB06EhjjTr5N0GVifZDiVn
 LP/g=
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

Check the return value of dev_read_addr_ptr() for NULL instead of
IS_ERR(). This function only ever returns NULL on failure.

Drop the now-unused <linux/err.h> include.

Fixes: 46220bf0174d ("aspeed: AST2600 Pinctrl Driver")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pinctrl/aspeed/pinctrl_ast2600.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl_ast2600.c b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
index f4bec6fe53c..af3eeacba51 100644
--- a/drivers/pinctrl/aspeed/pinctrl_ast2600.c
+++ b/drivers/pinctrl/aspeed/pinctrl_ast2600.c
@@ -10,7 +10,6 @@
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <linux/bitops.h>
-#include <linux/err.h>
 
 /*
  * This driver works with very simple configuration that has the same name
@@ -46,8 +45,8 @@ static int ast2600_pinctrl_probe(struct udevice *dev)
 		return ret;
 
 	priv->scu = dev_read_addr_ptr(clk_dev);
-	if (IS_ERR(priv->scu))
-		return PTR_ERR(priv->scu);
+	if (!priv->scu)
+		return -EINVAL;
 
 	return 0;
 }

-- 
2.43.0

