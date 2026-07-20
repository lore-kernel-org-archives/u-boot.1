Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0674EC4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 513C582991;
	Mon, 20 Jul 2026 10:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ecB2fKXe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 590CB83E76; Mon, 20 Jul 2026 10:33:45 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D6880517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-8f18d92172aso84316136d6.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 01:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536422; cv=none;
 d=google.com; s=arc-20260327;
 b=J0E8W6H08b2QFE6E8Ob8bYORIcjmm0LBOHIoQfMrvDBTOBdRIJo1RyRFOJiFdxMU82
 2WfZGgu4fJIfVfvgUz6nzYQKHfu69u28b0UCN93p9PytPLVhAWQiDxY3swwXv+PAoze2
 21wQyO0KY7E6q/eljOmoQDEB76Ke25uOV5wvr7SS+osEb3SNYFoGU6rdNYyEQfCZck5B
 lwO7zBnxqnkbuGlLHYExOgkSbKlVPVbYifvNHQ/iRU8bw/7QQfCKlJt9HIxGRI45z/uI
 giH4bvPUP94FZ9mTcwSm4iEBaW5PQ30ftLHmGKlQ1WKa14TtrCRJ9lDZpg2hM4ayonN4
 H+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vbVC2uxxMmlbv/DItzL5DEzW7SHzfvZg7xylgFhU2pc=;
 fh=o8hlnCAeO7huJDkf2l349HTZKj1Igh4Kp7x6HAXwr4I=;
 b=mPr2OcQVCQlBlnX9iPCfPb8PP5yxYzGGFGLG33OeBOfmLSPTU1W4u8zXgHB+SsvvwG
 iyMev11QKQ80Yx7ARlOABJu/mo+Phk4hEfKcMbLFQYVQd2AwV4wpO/ZiXFKakmeDMQdH
 y5db6y+N4lW/+VUfs5KavwtNaHXipEi70DIB2y0L3UFIqVOf0GbIv+odshM50Tcf+WIS
 xGK/QaiCfMNx+NHjLUMKj8o7m82dUjgy1wLanZrRUpcLcKk1ZwN2A7pi1PxqB/q8i882
 d9z+whtSF3DLBFtBdJV/X/NqaWY2B+jOaKynPbCbSX3BSDIQ0U4/pNy8Out12YmNIJ6B
 wQVA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784536422; x=1785141222; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vbVC2uxxMmlbv/DItzL5DEzW7SHzfvZg7xylgFhU2pc=;
 b=ecB2fKXeshF8SPBaXd/p6hFOsOx44FYJfmPem8Q00cB1fwHhrPN7Yjb9jPT8jXzOFl
 YYkv37Vepk9eJHlc7YQMJIBGWOqo3gDifRpmuaWvEYzGtClajww5nUkl0XsvSzKuIqar
 D4qZVviOr/L3ORPEcTbwiAqAYECNDGoefxbmHh1hpqkKULO9bMYQ0q3u7C53Fel0GbhZ
 COfmqqMZPIH62L+fAlvxOZQwwFRRpYGXEPv/R2g6AEhWQwStjKu3o+INmujkFEx2YvJz
 Om3YkLkSfzjPqKFJ149gU7RtxpX81X1blHhPZv5XldronL0KK4bZNwxYS5gdhG5dULnd
 tBYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536422; x=1785141222;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vbVC2uxxMmlbv/DItzL5DEzW7SHzfvZg7xylgFhU2pc=;
 b=ZinQd3XtTrjF+8FgpHfHyZpNAGuPIftZofWExbKG7P0MNt6wBbVJRq7As60pQgRzKV
 ag6x1hn+lRDK/GEFNpC7o0ifxWAP9XPmqyW1OBzi5x1XuDleUgD0YmVDvO71Ap+fiUXl
 sFXUpKvZYYZOfOEnlQ/knXxQcU6/6KNof60GnVsxcVbyYKaGI6m+U4dhvhqHD2gnYTJ4
 YCDreZBdpMUXWqj2tAGN42WHTampSZ9yOzbpgK2e++iTbaZZmIyqhI7aXeP4LnP5XQdL
 OnNhdsUy+zhEFx4bn3vfkqi3NR9iEo1J0QgQHyEEKlysPJQAW0RxlNATa23HaJtXl9Mp
 Zp0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYJQR4raHtnWS3DESvRKkjZ9VLL86YFCUox7ZHCWvUfL5vQP4SIQ2YW6yk6aIqzlyWkdaU/z0=@lists.denx.de
X-Gm-Message-State: AOJu0YzhX/x7QldXtXRut/jfWA6n5NjDa8A/oY+eVFmS8RGJDTMNlB/L
 FlLn/rCsO6j4B4IB8IUuS4DA/5X7TUfES3+RftiKWf/L7lVmwgN3cIu2JeiWSLP+mf17NoIs5Qx
 7z3Gagxc9gwvdP15jdJ7zMZ9pO3Kr2YU=
X-Gm-Gg: AfdE7cl/sDxafYibzOXEvdPBZwl91cEzh8ZnyDtlXd5UyXzXAAYWcbtTZLAw5PpqRte
 iHVYObhCT92zdjIPQC3Vc+Kjno7sKuIt5mw5qXpZlE/KZGw7CUyWKBrRpemRQrwFgVMD86udYOp
 r/e42pbQbUurKr5gfnv+hMqWGwXUadkVhZHSL64VwKOhPnfQDHQvcHy1TbNLMuDLxsCJ4AHZny5
 iHARgdZAJi7N6D0pUS+LzopxT0Y7fOnkEyL3SOlHwuDSZeNpN2wCiAY2P+V/mDJIGYDiZPsnTOW
 1E+nxOH43Bf+Hy7RwUIcOkWIByDkdhgkvxfIoVpUESBpFo6/1rJyQxDYuEZj7yDIsDXPzAIQYD7
 sDKfCnNm+nREnAZ6vYC73bSONo2wQCgMLkHLs+Ytui9wvVuo6Q5MgGVTY
X-Received: by 2002:a05:6214:4117:b0:8ce:b2e9:a4bd with SMTP id
 6a1803df08f44-9077832e936mr148636346d6.17.1784536422062; Mon, 20 Jul 2026
 01:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260720-osuosl-ml-switch-v4-0-20ec1c334dd2@linaro.org>
 <20260720-osuosl-ml-switch-v4-1-20ec1c334dd2@linaro.org>
In-Reply-To: <20260720-osuosl-ml-switch-v4-1-20ec1c334dd2@linaro.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 20 Jul 2026 09:33:29 +0100
X-Gm-Features: AUfX_mzCYlrQ5_lYSmK11Q9aozVrUB6q6pbPBNEBhWt2lNPqUAm4r-hjj5rIGGg
Message-ID: <CALeDE9OJ2xxq=2KNSPkvMHSgNOsOZ6KjkZGoUDZ-SjS+i0-qpg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] tools/patman: Migrate mailing-list to
 lists.u-boot-project.org
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.u-boot-project.org, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Heiko Stuebner <heiko@sntech.de>, David Lechner <dlechner@baylibre.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Philip Molloy <philip.molloy@analog.com>,
 Walter Schweizer <walter.schweizer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 20 Jul 2026 at 09:23, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> The U-Boot Mailing-list is moving to the lists.u-boot-project.org
> domain, so update all references of the list.denx.de to the new
> domain in the patman code.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  tools/patman/settings.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/patman/settings.py b/tools/patman/settings.py
> index 17229e0d823..fe65b1d3fb7 100644
> --- a/tools/patman/settings.py
> +++ b/tools/patman/settings.py
> @@ -162,7 +162,7 @@ class _ProjectConfigParser(ConfigParser.ConfigParser):
>  def ReadGitAliases(fname):
>      """Read a git alias file. This is in the form used by git:
>
> -    alias uboot  u-boot@lists.denx.de
> +    alias uboot  u-boot@lists.u-boot-project.org
>      alias wd     Wolfgang Denk <wd@denx.de>

Sadly I don't believe that alias is needed any more so should likely
be dropped too.

Peter

>      Args:
>
> --
> 2.34.1
>
