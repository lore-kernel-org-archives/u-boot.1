Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABD9C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 12:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7DCA60668;
	Fri, 11 Sep 2026 12:38:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gjh79CN1rkZE; Fri, 11 Sep 2026 12:38:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 248EB605F1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789130319;
	b=msp7y+mTBTAAJSWrpjlWC1UIqm81/BS/xvX5d2RvWVMKUm7yH7KVtsCtCUlmYXwglFOw
	 YOoSIBdKqikmJtkwksTCfJc3cGSMDCRBUc6oTchP7zsYTtekvcKv7tiHXqUwJqCIHigWR
	 ucPLaOoEBayzKPn+o4wX4MIt9X+2unkhN3dpLP1SwzY9OdaTQFRYfnhGyMK7PfUopOqZX
	 Iw58FkYFxwPys8f9HvNf0vgkdMNNozQOI6PyRiQzd/IS84dVY/9cnlwcGmrjWBJzVhSeU
	 9clJIkXHe/P6nz/3J4aAIpTCwsr/r7TIbXdv3xBIqYGgWcjwqUA5qQDuqrQDUPIjjTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789130319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lPeJrKpZnm6cSM9wMZzD6DHJGzwcqBhi47Pkj8WLTew=;
	b=dGdN0KyoUaPZWG/jYtbSlHSemOBWTfn9pirx2FiEqYgpTTr5xNhyivDjA9SCeCYw+rYQ
	 TMI9cW7wcFRJSWww+jZHJeuShwOEstUyYjxFBp9QhBvzmqSxrO9w7CyEtE9SKAw7bQ+hV
	 FL/7NKcT1nc75kJcboUUuAmnV7vUxujvAwXR0EVZmE5pb1Tof2dCkBxoZ+aTLYLhdn5KT
	 HzKfx33Lm5oMQHkV/65VM3U6LCBgh7Wmc1eDJgfPKWrVC63w2LU6Fgkr4RF3ueBsY0OpU
	 6peh1ucDN++5KrFlNjNtITxCx4o4lWdj4dAjfWNsJAzdGDuQQxeQgb3xrcVC7q0suYw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RA3pafHH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789130319;
	bh=lPeJrKpZnm6cSM9wMZzD6DHJGzwcqBhi47Pkj8WLTew=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HzC2xKRoWLsXpscqvdsGA2CoVUTyxXEGsQxc4ExkmLmYyLaK4gIYm6QQXoVzONOJu
	 tbBN/OwfJtTHIYtV8Ygo/BnF3Nsv7VpxuHQixKezsdNKvGIcMWndpKA9GQ0t/regIq
	 u/Bpk5siENJll3jzOlw7zvjs3NHHD5UHhrovKznd+5HxI1T6jSf2BxIgNYy9dRwody
	 bg6atVjD31za9dq+Zr+oge6Xd7tNyQIz7jkpaf94iNxOGhARIDI8mM737w8hWMwPZg
	 ff+AXskDNJnfnQ1tYZ8uhgokPJF9MBJngOsbNDFgN07hD8zSldeNuv9VHKoJ8keNrY
	 FZwlPv0mGkx6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 248EB605F1;
	Fri, 11 Sep 2026 12:38:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 518772E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:38:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4EED2605F1
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:38:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dB1AavQ5Mfdo for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 12:38:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BC032605E4
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789130317;
 b=PBuXk30YpMQBtZLT4Gn+iexgVT0okQgL/a9ad/a/or7/cb9VZbJpAVVPEzLIQshTOR1O
 dbcb94AEmvdrGfxg6W//IyrH+FljiVnGWoSU05O56NLisWdBDtU02R71IxHIf2GxHeOsk
 lw37nb83jALwJpJ5BbsSwoW+eQBUT4H9OFJq7iYLpBTPX4xo1cZweCrqvOxKXVye+GZ0F
 AlsvAIVt8rACFH/CDThp0lZlTRggJLk7eguMkyQGdXvvVyx+4BXmSQW0FuQFjyQBH9OfA
 jANjh5oboxFzxWbiJi0dJbkWzDuvzIB6NcNVEvOIbhkxFvoLuLx3lC9Rk/64C6Xs1RQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789130317;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=lPeJrKpZnm6cSM9wMZzD6DHJGzwcqBhi47Pkj8WLTew=;
 b=m+V/XOD4UR/EXnnzI94UkDMHbzCZ/nTvrtx8TcxgdLgCeLt6nHZMFhP61oECN58t9CLM
 pmbba4arZ9EURzk0GCCeLOsCnQnKHb3ZkMPTMkF/5WTKkXqhNTogbnX9oeczmLsZa7oU1
 q8K0b9kKUacVy8VSWSXo9zfYw6MpVL7X8SZTXenvyEHT4VR/hE1huaMmwipaM7iqqKu0i
 oX0W9wTBVFmzCIip3y4HDdSEMulP5qzIWxWt+d7A3ZOT18PaGqJwD7bDCtleTzMFCKxfF
 zVL22k5TC8dN/FKeZag4Kz8CoB6C8Al5v9Pa0VV4gdqRKkf7CQABRnVwpXntqyeenvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=RA3pafHH; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=RA3pafHH
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC032605E4
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:38:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2EE4460A57;
 Fri, 11 Sep 2026 12:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEFF1F000FF;
 Fri, 11 Sep 2026 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789130314;
 bh=lPeJrKpZnm6cSM9wMZzD6DHJGzwcqBhi47Pkj8WLTew=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=RA3pafHHb6b7yb9jXESW9ybcdXNOWsnUlGBhezEtneEloDnaCYKhsyZ3g+tLur/Nh
 wzRZV8I1+P3yWegkS2fsgjfzotrjJTtw8gQvcCNnebIndiG5K/1/SoOVSUHdtbR7NB
 fkkCWwgdt1WVgsMZRAKeu/SNAGcQ0rnNrUQNAup0ULm6gV0QshN9JaM61/YnQzrqL7
 M+cKyjdsrgHGz8hoYoDy3iCRMfYD9C3PTSiKJRhhXUm0hGChIJbq0kjOwyeoOkh7dx
 dmZikUMNaGe6gBIZCQ8OlX5qIHYgaa3O7iK5EkHX5RwBC0/qU0HWT+v03wsZG0SfVc
 W+NZiXH4K6zdA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, =?utf-8?B?TWFj?=
 =?utf-8?B?cGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Sam Day
 <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, Carlo Caione
 <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, Vitor Sato
 Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, Marek
 Vasut <marek.vasut+usb@mailbox.org>, Peng Fan <peng.fan@nxp.com>, Jaehoon
 Chung <jh80.chung@samsung.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Julien Masson <jmasson@baylibre.com>, Alexey
 Charkov <alchark@gmail.com>, Adrian Freihofer
 <adrian.freihofer@siemens.com>, Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Vincent Jardin <vjardin@free.fr>, Peter
 Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v5 3/5] fastboot: make shared configuration checks
 phase-aware
In-Reply-To: <20260906-ccaione-upstream-spl-fastboot-v5-3-023516e77321@baylibre.com>
References: <20260906-ccaione-upstream-spl-fastboot-v5-0-023516e77321@baylibre.com>
 <20260906-ccaione-upstream-spl-fastboot-v5-3-023516e77321@baylibre.com>
Date: Fri, 11 Sep 2026 14:38:32 +0200
Message-ID: <xhkdbcxuk3quv.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Carlo,

Thank you for the patch.

On Sun, Sep 06, 2026 at 22:02, Carlo Caione <ccaione@baylibre.com> wrote:

> Fastboot currently builds only for U-Boot proper, so its source and
> Makefile rules test CONFIG_FASTBOOT_* directly. The same checks would
> select U-Boot-proper options when these files are compiled for another
> phase, potentially compiling unavailable backends or using the wrong
> configuration values.
>
> Use CONFIG_IS_ENABLED(), CONFIG_VAL() and CONFIG_$(PHASE_) consistently
> for code and object selection. The empty phase prefix preserves the
> existing U-Boot-proper configuration and behavior while making the
> shared implementation safe to reuse from SPL.
>
> This also makes the Android boot-image condition phase-aware. Since SPL
> has no SPL_ANDROID_BOOT_IMAGE option, the existing flash:zimage path
> remains available only in U-Boot proper.
>
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
