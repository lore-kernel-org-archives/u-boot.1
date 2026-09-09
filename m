Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495F5C79F82
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 00:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADE1480D5C;
	Wed,  9 Sep 2026 00:03:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oagpk5uR2Ihy; Wed,  9 Sep 2026 00:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9CEBA80D6A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788912209;
	b=NM3kstbUReXFwxNVilkpB1NaPMEU2aqUViCeVlQ18LI0AOuG3KcKQozl+Z6yE15k8RRl
	 6hjBL6FWQqCpZAMyQfCtZ5UwNUza00/WG+OCcbehDSFHQf9d9pQB6NAdgM5N2ewf6g+GR
	 gJEhflpda9/rL9S8buA192lwCcFOJziS496WS8wgmLS9rKOaiPK2oeNvy7vejj32wmCY+
	 58VrO7TfNf5bLUY09DgvXOCQQcVdv8wHHognf+g+WK4vNslSbR7BVJHCh19LksmI9kK27
	 lLoSOFAIPpmt5uUrswhw3ghDiMWSQPXJ2DhctkS/CLyFH5c6AYSPaDqG9xh4eR4x0tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788912209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rZMu1SiBtV71w1K1u+c1aGcO0y0gJ34Q/QSMv6PkJ30=;
	b=Gb2KIRhArvGQa4LP3sjiTNz9KReuYpJzNs3xHlLhMZLhZp3zgi7bzcShJYHb7Pi4j/V/
	 NuLSnGC2fFTxK4kzKbOtNAbwFAs5BY+2IxjNZt/2UK+bBz7w9lFPnhS1iqf8CaD887z6H
	 rsIxQ1mbKrdEpHPdhZNIMPPxOJ6jCuvb4Z2PSqXPBIC0iLgp/b0nbKWQRTXROmiha841U
	 +YXBQcMGiUIlxlnfA1+IXTGQZsN9rg+3E6ViBbEqZMGuxCbBj9uyqmB2gGpfvvL5c8Q5g
	 6aJ4uZfs2wTAtv3jXa1OGcrDv30mHrrF0Zef/4ZnvxGCEwVcNSNmyztnhSD+WpkDhMA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788912209;
	bh=rZMu1SiBtV71w1K1u+c1aGcO0y0gJ34Q/QSMv6PkJ30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MkpPPtsPjO9KjhCMRnNFIZsV6w33Wl1sg6Bz9QrCTiiJNe+h02ef/0rp+eWILYZLA
	 wwefHiiO+bDf5F5lfM6VJjI77aCSiL+Rdsl+kO4NSawoUiIPIGM/RY9moG7mRBjVQX
	 S7Wlh1sf7KaP96eKGZRrFaKJ0rBMBd7dfZx5sVC5CeFWBvGxI8lXYg7XfRmZfXzFH3
	 xgsHH93R1aIybtpCW0/VVIRpMl28j7B7Z/K+ssgL1alUzhwt67H0LmLY8em17Udt4k
	 WyJam1Byx4VZPbD6PYoxJhJmj20SkP9teMiG7rN9ocT3oysIli1/L0VLH3D2YkkSCI
	 +mKOfNnjUBH6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9CEBA80D6A;
	Wed,  9 Sep 2026 00:03:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E3EAA701
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9F796075D
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uyvT31DHOJJX for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 00:03:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CE5626075A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788912205;
 b=tTzuNFtynh5CXdtsAZadnmTqY+0JBwDzuqoOBQM1RuRZE78tbKSNajXaoOXthIoH7vgq
 NjZZ4RH4WscNn9uJLCDp5NgnnslXJRtbsztJSuK4viAwAmt2cMBFmbIoF669+03EqFJds
 CIWU7/FevvP8NZuUdeOqU4M69ypYbtCDJodW5QrKI1ZTfgNt+iuv++6TAW5faYEwhDS8g
 3VVqqoRIFw9Dq7TNsw8zon39R2ApMqyNjQ/pTR1Q5Y6MJk9f9n8NmbaTe6RrCeXNFAqY/
 u28RNKiqkNK91YZKlgbCW5di38+860LmsLPWSSStgO8KfWYxaO9b4feE77FeQlU2hEg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788912205;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=rZMu1SiBtV71w1K1u+c1aGcO0y0gJ34Q/QSMv6PkJ30=;
 b=hDnPfqc1ozJ2VKu+BSNfmC7gzBWpC3M3suhyIAl9YxQOLf1C0TaO64JOPqZv+ZgVVbKR
 rSgo5qC8H/7FoqKrmbs6JzKkdxAVuwBSLDu8GbifgEIMT4t43cJqeTBvMIrUA1hCXNf0L
 MpGcNCcDz3BhtXKBdoqpDtApyE0xbckULmxV2AbmzD10c2JagPG6+Lm48CLZqKhC6LjkK
 zfxMCTWzM56eIZzQsn+gryh5g3ii+vzaS4u3BYFs7+Xm3qA6OvlwzCoPQ1bnDpHdpjqC4
 H5VJhkGUSSpZbX1aEudtadDtuE9gnGwbhHaAAwEE+E+zyNznh1R1mr2DFcIm8KtyetA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VUfUBsfQ; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c36"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c36; helo=mail-oo1-xc36.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=VUfUBsfQ
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE5626075A
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 00:03:24 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6b1b3d7f10eso3635355eaf.3
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 17:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788912203; x=1789517003;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rZMu1SiBtV71w1K1u+c1aGcO0y0gJ34Q/QSMv6PkJ30=;
 b=VUfUBsfQmvlL8x7I3ipPnjMgAixWMJ2e8QdH+1Kjj3c23Lf6lDT1XMnJkPqoXuIMjl
 dNIeKQk5ivklz2dhH52JSMUB0VsPLPjn+7gkeIa7qRyJOCxNYEPAIZqsRNLhI/E1TdOQ
 gbeb1Fzd1EP0v0os7xVE1ITt3e/zMuT+YQjnIlJTLFX0DgRzJI1r3i/eSYlX2btAAMoz
 UEfC9Bv3SfofqhP/aGsabQ3i7j9x7KoLEPvBk3X+rYkjVE73hwlGafwAv96j1JdqcZfP
 22JikoNDNrqUU1AzNn+uHNsO8d4y1z+gRNUkawx+a1lRvlZiVQwDLQ+3i8K2xZVylEFX
 vQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788912203; x=1789517003;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rZMu1SiBtV71w1K1u+c1aGcO0y0gJ34Q/QSMv6PkJ30=;
 b=DW+G5+MPwvbfMk/ucArl1fyVbzA8hRpe7TEo22q8uG3Tvu+XGGQdkLSHpuFEP+ogH3
 7rhfRbC0fgXilS4soMmg3vMOZiHyG03To8vFMIlIjUuQlD9qHVyoQtLSvDMTY2P/KJrm
 L46z0urd+eGrMRzzHCIokpAwmT9V1Ocs9iqRIkBVTO2fkshXedSad+89hH+V6Kg2Bkgj
 sKb+MwZl5VBVeJkAhY11j8VcxnsDlCZHTyD+IlH3xQxkHAPOf4kIRh6aloecOR33gZmv
 GupbIywI9pSa3u0iUDqcuCCNxJPYEudVM4ZUkjZrm3Jc0YgTSXDxZjFJgP/ILveRFl5y
 f3bA==
X-Gm-Message-State: AFuF++mvMlbUwcnJtwcK1837M5zQh6nCzJkyk9y0BGLu0fWT1g9xYfyH
 I2gZFrdgZ6hHzJKs47NAJdNU9+Fb2iFV3BW1q+QWE1Ctfqy22UwuQqmW6ix7okQ0PQM=
X-Gm-Gg: AYBFou2yB6Db3l4uOWWB4SKLDnsPzVqm06S7RaxL6EKHsq8rXIJy4uUUkis8HMFs4Ny
 0DDoasP5Dfx/XzE9J1/uSg3iQLSKQjOy12lXYSkpYDseEk3OEU0ejIpdGec5uISd0cHpcyp0J2M
 mjSFnTTjGOp3O5Zw7jyUBptIw49OhfCd/3vgUB3HPJSLNQqFcgdl5Mq+kagShm1kgeCSvsP3SgB
 JxRHYo/TsnqR7mUKsDXcOBo4iEtK1Q8jfMeH1U5J0G0/tqwcq8s01QV42IPqY1aSVRulyFoI2j/
 XBCylq+IiRjuZCE+1C63gXxpWM+OxMJomvQCu75uf7GywGk8KvPoEXehat7dgwJJJV+aoPSI+Y0
 lSeE3uAWeBe9DmxPmk86B7uPm57NIOASyVqmiiDLi/KBP3Rl80uCTIXh63GON4DxWEWKikdNWKb
 lVj7fU5yA7iNMU1epwhhliw0Wv4AM0TVbFVaqfnz4AHkNF7xuFQftCs2oPZpDEnFaSS+Q=
X-Received: by 2002:a05:6820:a281:10b0:6b7:8415:d798 with SMTP id
 006d021491bc7-6b78415d8b0mr11805907eaf.67.1788912203309; 
 Tue, 08 Sep 2026 17:03:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:ef9f:81b6:a41e:b9b3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b6deb11957sm16609908eaf.15.2026.09.08.17.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 17:03:21 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 08 Sep 2026 19:02:31 -0500
Subject: [PATCH 2/5] doc: splash: document the features added since 2013
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-splash-doc-and-scsi-v1-2-2345f5c4617f@baylibre.com>
References: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
In-Reply-To: <20260908-splash-doc-and-scsi-v1-0-2345f5c4617f@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5167; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=O206d9UN1VGc9M5vipSfbFJo4iKbZeG6UOGkOoWaMnU=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqoKIlUBpBE8kkKRZU6a20A9c2b/3BwFu6fP1t6
 5o6QhhocU+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaqCiJRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AVIEH/0qa+zZAtg498dWasTjZGZtJ4VVaq5kgpZmDY6a
 Q4oczRKEZvSZM8tfr7kjTeis4j+ovg8rDsDLUDcdt6Vn2imptlIYl/r7HpKGLbC7leaani2T/yT
 LvMOwiMtPu4m/KojyzJIMRFaEGG43W+Fnt2S4HIjDteAqkwFKCm+7XVp3g/PChXjrYiCrWUF9YQ
 4SpqH4Xz1zUa9bcAe9OWnkweie+lw59TtnGSdxGG+1ToDDJL10QHiS2QyKVgnp1sGVkKPh+PyGz
 +h5JVFTWFfZHzSZZ/irc3c83yRmBJtIUTKLLMhfX7Sq47ghRqadEuchYgbpSUGN4tGFj0uieeQ6
 zM8g=
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

The splash screen documentation was written when the feature was first
added and never kept up with it, so splashpos, splashdevpart, the
CONFIG_VIDEO_LOGO fallback, the version banner, the built-in
default_splash_locations table and the SPL variants of all of it are
undocumented.

Describe them, so that the document covers what the code actually does.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 doc/develop/splash.rst | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/doc/develop/splash.rst b/doc/develop/splash.rst
index 8b8d9d3a8c4..994951dec4c 100644
--- a/doc/develop/splash.rst
+++ b/doc/develop/splash.rst
@@ -3,6 +3,27 @@
 Splash screen
 =============
 
+Enabling the splash screen
+--------------------------
+
+CONFIG_SPLASH_SCREEN shows a BMP image on the display during boot. The image is
+taken from the hexadecimal address given by the environment variable
+*splashimage*. If *splashimage* is not set, no splash screen is displayed.
+
+Note that enabling this option also suppresses the compiled-in U-Boot logo (see
+CONFIG_VIDEO_LOGO), whether or not *splashimage* is set, so a board that enables
+CONFIG_SPLASH_SCREEN without setting *splashimage* shows nothing at all.
+
+Normally the U-Boot version string is shown on the display once the splash
+screen is enabled, since video starts up after U-Boot has displayed the initial
+banner and the banner is otherwise not visible. CONFIG_HIDE_LOGO_VERSION hides
+this version information.
+
+Note that this version banner is only printed on the video console when the
+splash image is left at its default position (0,0, see *splashpos* below). If
+the image is moved away from 0,0, the banner is skipped regardless of
+CONFIG_HIDE_LOGO_VERSION.
+
 Preparing the splash image
 --------------------------
 
@@ -12,6 +33,11 @@ It gives the board an opportunity to prepare the splash image data before it is
 processed and sent to the frame buffer by U-Boot. Define your own version to use
 this feature.
 
+If CONFIG_SPLASH_SOURCE is not enabled, the default splash_screen_prepare()
+falls back to copying the compiled-in U-Boot logo (see CONFIG_VIDEO_LOGO) to the
+address given by *splashimage*, so it is shown as the splash image instead of a
+board-supplied one.
+
 Selecting the splash image source
 ---------------------------------
 
@@ -39,3 +65,62 @@ environment variable *splashfile*.
 
 In case the environment variable *splashfile* is not defined the default name
 ``splash.bmp`` will be used.
+
+For storage backed locations (MMC, SATA, USB, etc.) the device and partition to
+read from can be overridden with the environment variable *splashdevpart*. Its
+value follows the same ``<dev>[:<part>]`` or ``<dev>#<partition name>``
+conventions used by the load commands, e.g. ``0:1`` or ``0#splash``. When
+*splashdevpart* is not set, the ``devpart`` field of the board's splash location
+entry is used instead.
+
+The default weak splash_screen_prepare() passes the ``default_splash_locations``
+array, defined in ``common/splash.c``, to splash_source_load(). It provides the
+following *splashsource* names out of the box:
+
+======== ============ ================== ===============
+Name     Storage      Type               devpart default
+======== ============ ================== ===============
+sf       SPI flash    raw, offset 0x0    n/a
+mmc_fs   MMC          file system        ``0:1``
+mmc_raw  MMC          raw                ``0:1``
+usb_fs   USB          file system        ``0:1``
+sata_fs  SATA         file system        ``0:1``
+======== ============ ================== ===============
+
+A board that needs different locations, other storage backends (e.g. NAND,
+UBI/UBIFS) or a different devpart default should provide its own array of
+``struct splash_location`` entries (see ``include/splash.h``) and call
+splash_source_load() from its own splash_screen_prepare() implementation
+instead of relying on the default one.
+
+Positioning the splash image
+----------------------------
+
+If CONFIG_SPLASH_SCREEN_ALIGN is enabled, the splash image can be freely
+positioned on the display using the environment variable *splashpos*, given as
+``x,y``:
+
+* A positive number is the number of pixels from the left/top.
+* A negative number is the number of pixels from the right/bottom.
+* ``m`` centers the image on that axis.
+
+Examples::
+
+  setenv splashpos m,m
+  	=> image at center of screen
+
+  setenv splashpos 30,20
+  	=> image at x = 30 and y = 20
+
+  setenv splashpos -10,m
+  	=> vertically centered image
+  	   at x = dspWidth - bmpWidth - 9
+
+Splash screen in SPL
+--------------------
+
+The splash screen feature is also available in SPL, controlled by the SPL
+counterparts of the above options: CONFIG_SPL_SPLASH_SCREEN,
+CONFIG_SPL_SPLASH_SCREEN_ALIGN and CONFIG_SPL_SPLASH_SOURCE. They behave the
+same as their non-SPL equivalents, but apply only at the SPL stage, and are
+selected and configured independently of the U-Boot proper options.

-- 
2.43.0

