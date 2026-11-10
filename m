Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EF7606A321
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=io5kVVC4;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xv6ncyFE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D7A44058B;
	Tue, 10 Nov 2026 08:44:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EdYt4AO0OR_0; Tue, 10 Nov 2026 08:44:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EBDF44059B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794300242;
	b=A7elBg1mFlrJwxqDFSBjqYcU/ApYSjOQhmXqNQmB30fK0djeIMc8mNx1E5PK4E1n4FQm
	 pBqjaVa5DEP1MU2ylvFnpLewIR8Xi7kBu1JtTVstdUYM9SMPVbBg7mPPhafnxGozv/8Qn
	 thID6bOF0e/HQc2yjXyWHksDqJ8DJwjjlP00UaO/TjTjDWz+KMKo0kSsCusc79Tp6mzSl
	 L0B/VkRY8YgIy2S7jM/BVMT008dAV8ZIi9mhxXRmk+8W9V1MqbOmUR+BjJJTTZMNDqKGH
	 FM0fUIAz1ULrbH2+CYZxwKCf3m9N9jxQBWYHt81myyTNL9dKgdTLpim+fWCewh0P91A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794300242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MdKxfy5nIKExvtw5Z9pQzEWtZEuqiiilUcXMQmKNlP4=;
	b=JrwFM9KQUxzczjnVYByf2kmQUTYibhj0g2tiID2qGyj1/iMCBaC1KtMcn75hPmMLRKUH
	 zw2aXnJ4VKAIpskeNr6KVTS6mi/ZvbkGd8HKA6Vs6UB82BEIc48b4L86g/gmWgA111tsA
	 3SRD29ApFdkdStXr5hCQBcESPdiA8xkVErHcumnw39KI0Sct/8NncbjweEwXmxqZyHBNn
	 ntP8qekGcBc7rCSixwv/2UlvZlQiontPGmoMPGwtyFZDSQhyB/LzKWxB/i7UO7cDhIbyj
	 ffDVUmwpcxmFB36hHwQ2juSvNn0n1AWiU+dLUFZQjRBDguMNOXi/bwd2bCmluQBE8qA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xv6ncyFE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794300242;
	bh=MdKxfy5nIKExvtw5Z9pQzEWtZEuqiiilUcXMQmKNlP4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=io5kVVC4v5Go4Ix6lEZMInSGfgMHZiSzortUc3X5npMDl3RmKKIpUW97rI2a+iRdF
	 PA9tt6vvpxGTYi7CvZ/Xhz4bUa7K9pzkcRQgyn1Dn3jv2VXqLnyyyHDu6vooZmX7eV
	 W/gYo6XsgQvglPeMFPhN4mxYKzXttao5uvxs3+VUhCFdJkPyDsgL0NFegNStKOM3MM
	 i5dYc2phmsZoNi93d1/C/AwCNGJ0w7ML9hhcWTbDA2grsLnm9ZqtJy/krfX8fRaBqO
	 aYbN0b/7rvYZnUgvoC9nMoL5CtQ42LSDJSuMINEVoN6S6T67/Xk9J7whKg9166GKCg
	 ckh+F427LMbOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBDF44059B;
	Tue, 10 Nov 2026 08:44:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E2404B8
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:44:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F6D44058B
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:44:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BGxQqtL4EAnM for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 08:43:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 492904059B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1334; helo=mail-dy1-x1334.google.com;
 envelope-from=clamor95@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=xv6ncyFE
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 492904059B
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 08:43:57 +0000 (UTC)
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-37071c0f42aso3228136eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 00:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794300237; x=1794905037;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MdKxfy5nIKExvtw5Z9pQzEWtZEuqiiilUcXMQmKNlP4=;
 b=xv6ncyFEnsrSnwyX/A2PzruJS9kjAneaqjSimogsKtKR8UnfhD/6j4qLPbVLybMtTS
 SU7f88LyeaWS2alPUMK9sW1A2Y0SW9g/0VhT2adzqFwFlBUzG+rKFbZI0OPO3b3GAvGF
 /dj6+WKIeWEPNI/z1SDbI52rbQ5Wzp6I6AJYnz0QeRO231TSrAlqgUvmQReIN6D0xMju
 d/uPDQ3pFgxBrHxvvp1H8iIvUJJNWa4DrtIYyWKwpVN0+hNowINgIdIg1N9VtkyX0x+m
 iG1MH2OnFwbGNO1kSllUOYJoUhOFSlJJT+o81ZVARIOyeyQ1iPZbozuBxyP+JLrh6FPx
 uEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794300237; x=1794905037;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MdKxfy5nIKExvtw5Z9pQzEWtZEuqiiilUcXMQmKNlP4=;
 b=z7hpQ4TK2qH6F3wBpUFUoFoUPeAHL7+eQ25L3l7BCsGFZGNpyImXrAocnC7l0sd5Z7
 EKTu3wpIiN4i1sukL+y919f9glqHJ2imQXHkh+m7dddIHIzb5YaX9RNHl4uKpUPy/348
 3KmOxScN7ourWFNXvjvvYDv+ZvT9FU/3aPLyE0QE+vPrQd1kS1LYAiWwAwuFw4g6IHX9
 gEQGs1+oVBshVyOT4tHHF5WbbFSnED9bTUIMkPmQJqNQSNo/JJg7uYSYezfGhaQ1S7Rk
 QfzsbBSsnjbLMpoKuUnzNgjStmWPmRpAEimkao1XYpufTv8icFGmpOr+ezeEebcVaMh7
 0d0g==
X-Gm-Message-State: APuU4Z/ZwhvK+veZeqS9V020hJrgTh6MMvjYJT6et12e7Xy9LwWNtLMv
 jBVfKKtNUB3CTw0vZgmraDbXpBThgUY4mGVbYs9YEHUotaiUXLfIFCYrD9dKeIlafsQvOG/kOda
 aPeRAcdix0krnf6FaiawJlcBbRMWQdRY=
X-Gm-Gg: AYBFou1QjrNPGMxLLIBjNSX9I+uB5Z/My0S4fW6HEYR2nqLodEN7FvBdwftP/vgwXKF
 x4itVqb+0t0Go6HkepiNf5mEvEpPyoOdnsNpAGdHuE2Q8ZJ81AZfQgf/Ek+SB8OWyaVksYr9Qkf
 BBmRcbrRlT0Kc4e1VHxDE6e5RvlQwNYngL/oyO4SbEZHLiarApKUVpAT0JKf9/0dATURrL3ioAA
 jw8K5b0v5LcB863M1I+2a+m/4+5nuQZuW/pG+UAcdP8sN0wGgF7lS56B0c35u4A+EPTtU0NtiV4
 cK1w1lWfQd5IrzaGhGtgyQUHG7WmNX4brQJATrG+GIwXvDtQUgWpwPaSXcYd+vgTx/GryZSMYgA
 rBsMHHW9l4MNyCQ3bU8Inz/gvfEAQyUNI52aAbSAk90xa/SRSZJqNoXhnaLnjBYYg4AKpRB80zf
 uEx4EGnoPxUqKWAA11IkZSh9XGNCIk7A==
X-Received: by 2002:a05:693c:8845:b0:366:9f06:3c4c with SMTP id
 5a478bee46e88-3751fe3228cmr2243277eec.32.1794300236731; Tue, 10 Nov 2026
 00:43:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <54ffbe6d-668c-494f-874c-b5f34b84c593@gmail.com>
In-Reply-To: <54ffbe6d-668c-494f-874c-b5f34b84c593@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 10 Nov 2026 10:41:23 +0200
X-Gm-Features: AclHuK9XKFPqGrZjDcb8E_I2ZEY89nzgsNPQcSHcBqCntHOHyiiZ369osA1ZV8M
Message-ID: <CAPVz0n2kOOddS+T_8-hJjzZt9-T1-HtebwxA9_fcw0SwzWVy-g@mail.gmail.com>
Subject: Re: [PATCH 04/11] video: display: Skip modes which do not fit in the
 source frame buffer
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>, 
 Andre Przywara <andre.przywara@arm.com>, Thierry Reding <treding@nvidia.com>, 
 Tom Warren <twarren@nvidia.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D0=BD, 9 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 19:29=
 Ana Bobillo <anabobillo3@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> display_read_timing() picks the first EDID timing which the display
> driver accepts, but the display driver does not know how much memory
> the video device feeding it has reserved for its frame buffer, so it
> can pick a mode which does not fit.
>
> Add the size and depth of the source's frame buffer to struct
> display_plat, which the video device sets, as it does src_dev, before
> it reads the timing. display_mode_valid() then skips the modes which do
> not fit, so that a smaller one is picked. A video device which does not
> set them is not affected.
>
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---
>  drivers/video/display-uclass.c | 10 ++++++++++
>  include/display.h              |  6 ++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/video/display-uclass.c b/drivers/video/display-uclas=
s.c
> index 85dac12a197..06888df4112 100644
> --- a/drivers/video/display-uclass.c
> +++ b/drivers/video/display-uclass.c
> @@ -42,6 +42,16 @@ static bool display_mode_valid(void *priv, const struc=
t display_timing *timing)
>  {
>         struct udevice *dev =3D priv;
>         struct dm_display_ops *ops =3D display_get_ops(dev);
> +       struct display_plat *disp_uc_plat =3D dev_get_uclass_plat(dev);
> +       u64 bits;
> +
> +       /* Skip modes which do not fit in the source's frame buffer */
> +       if (disp_uc_plat->fb_size) {
> +               bits =3D (u64)timing->hactive.typ * timing->vactive.typ *
> +                      disp_uc_plat->fb_bpp;
> +               if (bits > (u64)disp_uc_plat->fb_size * 8)
> +                       return false;
> +       }
>
>         if (ops && ops->mode_valid)
>                 return ops->mode_valid(dev, timing);
> diff --git a/include/display.h b/include/display.h
> index 26b965daba9..f2ff9ffced8 100644
> --- a/include/display.h
> +++ b/include/display.h
> @@ -18,11 +18,17 @@ struct display_timing;
>   * controller
>   * @src_dev:   Source device providing the video
>   * @in_use:    Display is being used
> + * @fb_size:   Size of the source's frame buffer in bytes, or 0 if unkno=
wn. Set
> + *             by the source before reading the timing, so that modes wh=
ich
> + *             do not fit in the frame buffer are skipped
> + * @fb_bpp:    Bits per pixel of the source's frame buffer
>   */
>  struct display_plat {
>         int source_id;
>         struct udevice *src_dev;
>         bool in_use;
> +       uint fb_size;
> +       int fb_bpp;
>  };
>

Decent idea

Acked-by: Svyatoslav Ryhel <clamor95@gmail.com>
