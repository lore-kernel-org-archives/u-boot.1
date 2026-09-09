Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA23AC79FA1
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 00:03:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E32D80D52;
	Wed,  9 Sep 2026 00:03:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5agfzsdk_nQw; Wed,  9 Sep 2026 00:03:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9E91F80D2C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788912206;
	b=MSkRJgYlTs5QVIHT0Mo8BNIfQHCMvje/8dfGuRjtLlxy74QRj/+ZuNopuAPuPXOyHItq
	 o0edOw9ANJzjxIasg0f8lYa9twa1mvR35p5XBB4H2raVcRSeSqhU03JuxQOWxDdJdc7ud
	 QLdhRVzlHUInQbcsntLtJOQb+FmZrVKkRMCAbGgUAUnTCE3geW/v1c8T8UIFOxlKAWjv9
	 57OriqRcj9xrEOcJUA/L6J+M8tCOBqOVhLf41tIG0XgsDZoHDZ52GtI3elpgEYdsMgmeD
	 E2yLUshpaqMVzIaO2lUuIVboyanmiJud3QSh2Hy16FFvXo+8jc3katO5wMuhg5F5WVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788912206;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FJtdO+yVLirQ5NPOxS1mrV2KDpVPooDdd9vp22/FB8E=;
	b=NdUhdrSOOl/vDJuc3QmzWjmxPLpGLXX8xjRX4zCJGnA2Szw6/byry9oTzuojidyVyTbW
	 u3iUysMJd1BS4K1qHX0C6iWNtPwK1tTs2sf/h7VrSqUxsvnw6IDDZx3SuxYa/xgMI248l
	 Z53NuSm8GOWqh5VKuaiUWP+YXysJEC/hu6FIqemYiEtBWZGUAGRE6dQ5eWdKE2eBA+N2/
	 cLu5ILlvDAB4vdBYACeDGNl8sv+/OfyxAV+7KqfF2sNsirZXy4dKK1x2JwuCFhRqwRrCD
	 J28tgG0quK53+/GsjYs2agEhOMGPF6aISvk96vOP9aKZ6JKYJEOTX5GAApbcWZOlE7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788912206;
	bh=FJtdO+yVLirQ5NPOxS1mrV2KDpVPooDdd9vp22/FB8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wCOYzJhmmq6a/1bhV6JEQTU432kBG+OKmirI6Y20zLMN//W8ReD5gE12ONX+SgrUc
	 UBN83WS1855cfyhY0maCEVcEdxRaOPru1iTJOBVl/JviFUZFgQJfHKZMD9YNjQ/Sfv
	 +n7F+wrQkDudG3acGVuGLpQrjJgANh8rpw0ZtuSnb2dvC/s4silrEz5M3BbSZY+FbA
	 ljzJtpDQPxqdGqH9M0+tqzXFwd4ZT1W3uNsfBxGxbBTshWWexG2vm0gKVxDF9gCGTf
	 saqM9d/DO9PfdIGii05JjnkJb96ceRD2M9Q86zXY+3pCHzBhxPROzR5dfZy77OdGD+
	 X4COhYeb0MxSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E91F80D2C;
	Wed,  9 Sep 2026 00:03:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 00560268
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E69C3401EB
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N1jF6q6pSmDG for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 00:03:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org E1514401E9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788912204;
 b=Y27MuuGcFQKT1vDz6HEJIcei3n/7+ZU7lxDpO/wegjAZaNBIoEw6wFvCDlbmENCnZYbS
 3imlDYehLGXuPBOv/OU7jFPIvppkA4xlIMXAmmS42YQJ2xAwnpeXnfpE7XfqKK84WuXBa
 BdQC09GyUDleUKsThsB0n8qyR2Qz0Hd6OTybCukEbmxEwQUsC7zFXr+8C/cur6rrHkjuR
 /+/HXK8ZVaohc9Rdq1JyKk0Rkkz4fFxClQ7Sti/JiunFy7WIGJfhMZhPR+8145LZQduFj
 SDZWPtCY7av18LHvWds2OpVjankW7WKNEugKs1yEIR+/3pJZiFqfumXecPl9T+IF4mw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788912204;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=FJtdO+yVLirQ5NPOxS1mrV2KDpVPooDdd9vp22/FB8E=;
 b=pnEk8M8KotUTFSHkBQ3CIr8Ux82YY7DwxauCt537AkZlNLe9i+BC2gcpqsvCEH2lFjJf
 o26K/GIyWU71DfNMHM6hqQjDZDw7bZNy+/LJam+AFpi5H5Y/zGz+srNmHlVBZqObwIV61
 SEWHUzSpSXtOE1YEqyXVY2NYHGYdASn4y+M2nteind1JnPT9Xzjoc/kbbzMKNKAOPLRSE
 qayV2QCf+skGJtonrCKolGHCCJK81xrtAmcneo7onaPzIVUDoOS8ZU0lHDtr9JjEyjJHN
 ArHK5fEQeYD63925dRN/Iz9fdgkYUoFLBH8q76lQiClCKFFhc90LCkv2ApJECQFyT7w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VARMYUNJ; 
 arc=none smtp.remote-ip="2001:4860:4864:20::34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::34; helo=mail-oa1-x34.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VARMYUNJ
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E1514401E9
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:21 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-43bf9548df4so4955728fac.0
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 17:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788912200; x=1789517000;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FJtdO+yVLirQ5NPOxS1mrV2KDpVPooDdd9vp22/FB8E=;
 b=VARMYUNJdX5qxoHijBk0RwlmUrlssby/jgceaPH9x1NtZoDs91R2sIfmoQl9OdLIR/
 hBbIsSBimugADZnc77GjQXmI+5RFXjPLhTZoXOFgIefIG6Wya3cRvVy/uLIlrCFtf435
 WPW74Ihg0z7Qt4aT9mkZsPlF2iwooWpwUId0vqfA8Uk+tRTPDM6twsewc1KwsSDxBTwD
 d+i1Aan6zG5CEpTXxUYcrthNuTIrIsAN+c1mJ/GOQbyafK4dP+9re162LSeNyY5dpV8K
 hA9rJkUr846eG5ism34mPwFzwyySatcBelAwh1tSlCErSgSxVBD+2a3NxSC1wqaQFhGe
 INTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788912200; x=1789517000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FJtdO+yVLirQ5NPOxS1mrV2KDpVPooDdd9vp22/FB8E=;
 b=qDy9Nc+d6hHsTBfRe9tQBEOe4qKCXNZZCYTl0FHYC6x5Og9aRbPgQmrpa/xoAo/R72
 oRjaPHYW57h0VsmCQUaEoVLto6nlKYPfSKlGEIztrn21HOkNC2B3dnso2GWCXgpGD4GI
 7+eEzVFiZX+GAyVOjplBrseZuyT0YQMllRUTNOBtoNfA8xjB3N5qRncOkTQrdP7dQ1wh
 udWY8FlkkKrguHBXX1alGCo66djr7OFL64EahThRyTDP4cKcxMvT/f56ULIZ+cIWlPav
 25DsvisQlFsu2gvulF6e6BFFtRbpBy6Y4P9E9L1VhLbawjvJULppWVcyWmEh/l5UUuW4
 4YOg==
X-Gm-Message-State: AFuF++leq8OqyGn6o3xsfJAyTH0eB7jm4HAZMRGPTz365bpr8DIwfddK
 mftIdiaVLA7rreTJAI2tdk4h/d8GnpU0qGDbJwPVbAAtjCUiajZKK5P14af7Ot7icOg=
X-Gm-Gg: AYBFou3bF6bi0Ik3UGVKMJBfGH2xe9sRf8KxfofKsQbKn/VSMNYY7h73UcKAKnhh3J5
 DSG127mjqI2etOu3Ml+BLYGGiIFqEY3/azrSLB7zcN/b2FQ/SdGfBP1TdxXqRv4mh/NImihjiZ8
 Az8eKAq34ARoXpfyrC+xykAOEjjLxhcdtxddjp/WSVVcmddTJzt6eTX9I4Emxso67mS0g3Uov4c
 LotnODc5NwZUtmTeSxumjhXhUts81qzm/3UFvCT0+rV5oO+Srae5c4yCOdKBppo6JstiRTexdOu
 rD934U4t5dI5ck3gCSHxn84aXr8ET0et0c92QPKC7AVSOT8kUJH7s2TOVVY4aRkj/RLSbcbjOqy
 sVycxRLKGMAuMeW+RW4b2pytXZI5L5fgR0lyZkm3WVnOs69jDvo6EvGa7cK9t0ZpvllMEkP1115
 83OUD5RKvco/1gUkK6tWWLb6IAWSUon3nW63zdHReqvJtKg1L+qWaPCEBXip7bCVdv2s1p9u0hx
 AwB
X-Received: by 2002:a05:6820:611:b0:6b1:89ff:8a1a with SMTP id
 006d021491bc7-6b6fa5e803dmr20045948eaf.3.1788912200266; 
 Tue, 08 Sep 2026 17:03:20 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6deb11957sm16609908eaf.15.2026.09.08.17.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 17:03:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 08 Sep 2026 19:02:30 -0500
Subject: [PATCH 1/5] doc: splash: convert README.splashprepare to
 reStructuredText
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-splash-doc-and-scsi-v1-1-2345f5c4617f@baylibre.com>
References: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
In-Reply-To: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5241; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Fm2FGJ2D97zv40i8mNkI4k3Tkbn3QRUMZe6K+f3NO5A=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqoKIeScAe/X+omoxYezw4KSLntVoa9/mZk0E6d
 9MjT/gQqEeJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqCiHhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AYykH/3utW1NL7luOv4JCDLeSDHxHjaE8DgUfjTJqwwY
 8UoascW7Bfj+OkYgvPIiSqb+H17a4WBDoQwlN8NvGWizJoMUkobTM9R+Ed6lfUgfiIVGuwagDFU
 tkmXRwBd+h1YL3ZLvV4C6yYdoqlWYPi6MpXHsOlUrAPq/KEXUoZK+NPZWkBfrrk+ldzI1Dg9qpK
 LAYL9IcB9WIzUkeaat9MoLj0cfSfQ2hFSCpH92z94S3+ekoDOqlhdSOCY178+CXDCBflhaohqLW
 YFWmLb4xTjSHWG53l0A8HtEAKxP20KaDaav3efSiqijnBOq/pmEfk42wNyextrm1kWDIUTi8i7E
 hIYY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Convert the existing doc/README.splashprepare file to reStructuredText
format and integrate it into the documentation tree.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 common/splash.c          |  2 +-
 doc/README.splashprepare | 34 ----------------------------------
 doc/develop/index.rst    |  1 +
 doc/develop/splash.rst   | 41 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 35 deletions(-)

diff --git a/common/splash.c b/common/splash.c
index c5591293634..8cc9e28ccdf 100644
--- a/common/splash.c
+++ b/common/splash.c
@@ -156,7 +156,7 @@ void splash_display_banner(void)
 
 /*
  * Common function to show a splash image if env("splashimage") is set.
- * For additional details please refer to doc/README.splashprepare.
+ * For additional details please refer to doc/develop/splash.rst.
  */
 int splash_display(void)
 {
diff --git a/doc/README.splashprepare b/doc/README.splashprepare
deleted file mode 100644
index 3cb5b5aeb48..00000000000
--- a/doc/README.splashprepare
+++ /dev/null
@@ -1,34 +0,0 @@
----------------------------------------------------------------------
-Splash Screen
----------------------------------------------------------------------
-The splash_screen_prepare() function is a weak function defined in
-common/splash.c. It is called as part of the splash screen display
-sequence. It gives the board an opportunity to prepare the splash
-image data before it is processed and sent to the frame buffer by
-U-Boot. Define your own version to use this feature.
-
-CONFIG_SPLASH_SOURCE
-
-Use the splash_source.c library. This library provides facilities to declare
-board specific splash image locations, routines for loading splash image from
-supported locations, and a way of controlling the selected splash location
-using the "splashsource" environment variable.
-
-splashsource works as follows:
-- If splashsource is set to a supported location name as defined by board code,
-  use that splash location.
-- If splashsource is undefined, use the first splash location as default.
-- If splashsource is set to an unsupported value, do not load a splash screen.
-
-A splash source location can describe either storage with raw data, a storage
-formatted with a file system or a FIT image. In case of a filesystem, the splash
-screen data is loaded as a file. The name of the splash screen file can be
-controlled with the environment variable "splashfile".
-
-To enable loading the splash image from a FIT image, CONFIG_FIT must be
-enabled. The FIT image has to start at the 'offset' field address in the
-selected splash location. The name of splash image within the FIT shall be
-specified by the environment variable "splashfile".
-
-In case the environment variable "splashfile" is not defined the default name
-'splash.bmp' will be used.
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 0b757e8601e..2d8bf6a4f71 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -53,6 +53,7 @@ Implementation
    printf
    smbios
    spl
+   splash
    falcon
    uefi/index
    vbe
diff --git a/doc/develop/splash.rst b/doc/develop/splash.rst
new file mode 100644
index 00000000000..8b8d9d3a8c4
--- /dev/null
+++ b/doc/develop/splash.rst
@@ -0,0 +1,41 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Splash screen
+=============
+
+Preparing the splash image
+--------------------------
+
+The splash_screen_prepare() function is a weak function defined in
+``common/splash.c``. It is called as part of the splash screen display sequence.
+It gives the board an opportunity to prepare the splash image data before it is
+processed and sent to the frame buffer by U-Boot. Define your own version to use
+this feature.
+
+Selecting the splash image source
+---------------------------------
+
+CONFIG_SPLASH_SOURCE enables the splash_source.c library. This library provides
+facilities to declare board specific splash image locations, routines for
+loading a splash image from supported locations, and a way of controlling the
+selected splash location using the *splashsource* environment variable.
+
+*splashsource* works as follows:
+
+* If *splashsource* is set to a supported location name as defined by board
+  code, use that splash location.
+* If *splashsource* is undefined, use the first splash location as default.
+* If *splashsource* is set to an unsupported value, do not load a splash screen.
+
+A splash source location can describe either storage with raw data, a storage
+formatted with a file system or a FIT image. In case of a filesystem, the splash
+screen data is loaded as a file. The name of the splash screen file can be
+controlled with the environment variable *splashfile*.
+
+To enable loading the splash image from a FIT image, CONFIG_FIT must be enabled.
+The FIT image has to start at the 'offset' field address in the selected splash
+location. The name of the splash image within the FIT shall be specified by the
+environment variable *splashfile*.
+
+In case the environment variable *splashfile* is not defined the default name
+``splash.bmp`` will be used.

-- 
2.43.0

