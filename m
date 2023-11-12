Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDA6C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0254F874F0;
	Sun, 12 Nov 2023 21:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OZiV2+6x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BB1874ED; Sun, 12 Nov 2023 21:04:02 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6852987026
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a81ab75f21so43467257b3.2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819434; x=1700424234; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hxWdUXpnUthLbmKexLhkzpZBQMKB8Dt5q5IkEUxMbIA=;
 b=OZiV2+6xYOzPsdf3CkkE4D6O8Wc+5Z3ZlFj6404De2FMw8FgcNmyLNQioUlz4s+0pp
 AQitXu8DBla4211dFSIykdC4xE8V9Hkx6YE9U/At4Kh5hWFmyX904eGG0td8M8qQm+TZ
 RDEk0Gg3vKSDDtSxMRl6hiDfTsi5Q1xFhZmO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819434; x=1700424234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxWdUXpnUthLbmKexLhkzpZBQMKB8Dt5q5IkEUxMbIA=;
 b=rDL2hLzmm7wz8h90BCKnYo7z4tzC6C0jgMK2lR4jOyTIKXGiwAAI9DrSvWFS/lHiPH
 mMRICsklnhd2h7ZZvlu+JRVkIrYs4zkZvKg5sVPF1sBxDUjKJO/QUjrDIjcOYg4ZVINz
 d+FI2LasF9aLCl82NgS/YhT9GVvA419fZQK9a5KBIYXpzEpwPGdfQ9Tta8rq76rpVZIc
 a26CC3XiK36Rt2Nhx4YSd/AIeXCujaG9483g2Pj1+v0IYNLX6aIO3Zd82KHrrys7kFzO
 0giFZsEckonp+90/Yn4ObpXp6vRzxO8OIyJlV3vIboDWLs8T4ZKws1ZzPnYirmFnn7gs
 dCig==
X-Gm-Message-State: AOJu0YyMzA6MfIrLQ5NlVWrKJAsFUYm8er3nUWCJgwQGDwO9tfNTIHqV
 WfZzHdiJXZ5S2Y9dEGBL6TG3rpYzrVyVLUtJOAIwQBaBQ9ktoEE9Geo=
X-Google-Smtp-Source: AGHT+IGyOf9MUtcp6/nTzhhtz3DdNvBQWAATM424hgulqzRKpRjNCAYSbO9dzsHbnIRtmfYq2jmZ0JLSYLfRZN+VC5U=
X-Received: by 2002:a05:690c:4683:b0:5c1:47f2:6e05 with SMTP id
 gx3-20020a05690c468300b005c147f26e05mr3250068ywb.9.1699819434105; Sun, 12 Nov
 2023 12:03:54 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231002011450.462468-3-sjg@chromium.org>
In-Reply-To: <20231002011450.462468-3-sjg@chromium.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:11 -0700
Message-ID: <CAPnjgZ0r2j7iRY5FpcKVUx2AHjaKDwtdL1Lars=MJbBAEMAOkQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] video: Correct setting of cursor position
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
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

Hi Anatolij,

On Sun, 1 Oct 2023 at 19:15, Simon Glass <sjg@chromium.org> wrote:
>
> The ANSI codes are not correctly handled at present, in that the
> requested X position is added to the current one.
>
> Correct this and also call vidconsole_entry_start() to start a new text
> line.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  drivers/video/vidconsole-uclass.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
> index 22d55df71f63..a312a1985242 100644
> --- a/drivers/video/vidconsole-uclass.c
> +++ b/drivers/video/vidconsole-uclass.c
> @@ -125,6 +125,7 @@ void vidconsole_set_cursor_pos(struct udevice *dev, int x, int y)
>         priv->xcur_frac = VID_TO_POS(x);
>         priv->xstart_frac = priv->xcur_frac;
>         priv->ycur = y;
> +       vidconsole_entry_start(dev);
>  }
>
>  /**
> @@ -134,8 +135,10 @@ void vidconsole_set_cursor_pos(struct udevice *dev, int x, int y)
>   * @row:       new row
>   * @col:       new column
>   */
> -static void set_cursor_position(struct vidconsole_priv *priv, int row, int col)
> +static void set_cursor_position(struct udevice *dev, int row, int col)
>  {
> +       struct vidconsole_priv *priv = dev_get_uclass_priv(dev);
> +
>         /*
>          * Ensure we stay in the bounds of the screen.
>          */
> @@ -144,9 +147,7 @@ static void set_cursor_position(struct vidconsole_priv *priv, int row, int col)
>         if (col >= priv->cols)
>                 col = priv->cols - 1;
>
> -       priv->ycur = row * priv->y_charsize;
> -       priv->xcur_frac = priv->xstart_frac +
> -                         VID_TO_POS(col * priv->x_charsize);
> +       vidconsole_position_cursor(dev, col, row);
>  }
>
>  /**
> @@ -193,7 +194,7 @@ static void vidconsole_escape_char(struct udevice *dev, char ch)
>                         int row = priv->row_saved;
>                         int col = priv->col_saved;
>
> -                       set_cursor_position(priv, row, col);
> +                       set_cursor_position(dev, row, col);
>                         priv->escape = 0;
>                         return;
>                 }
> @@ -255,7 +256,7 @@ static void vidconsole_escape_char(struct udevice *dev, char ch)
>                 if (row < 0)
>                         row = 0;
>                 /* Right and bottom overflows are handled in the callee. */
> -               set_cursor_position(priv, row, col);
> +               set_cursor_position(dev, row, col);
>                 break;
>         }
>         case 'H':
> @@ -279,7 +280,7 @@ static void vidconsole_escape_char(struct udevice *dev, char ch)
>                 if (col)
>                         --col;
>
> -               set_cursor_position(priv, row, col);
> +               set_cursor_position(dev, row, col);
>
>                 break;
>         }
> --
> 2.42.0.582.g8ccd20d70d-goog
>

Any thoughts on this patch, please?

Regards,
Simon
