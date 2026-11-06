Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC1606A33B
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lhcrfc4C;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gNK3EvCQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D642660AB9;
	Fri,  6 Nov 2026 21:57:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i3d9E9K7jbnA; Fri,  6 Nov 2026 21:57:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 316FB60A59
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794002262;
	b=QFFAesqwF+/YHmheLX18a5kfHg//76KFkMpSnp4owxHIInpul6MG5693BFqdjmzAGNQw
	 bAazjciBJUUf8mXeGAt0VFql41sDbjh34GpRcj17zcmoWjpT8TqG9ac5JZQc0oRFryYYT
	 pTM57ZgxnIg6U4UUYWpsx6NCYXYSKC9Y1+Brpg110NMZBhMcXVGe0NL49TxtCUiT64AGj
	 9PY0cf6Iw5PoXxbUWBWlYYEaR5ZpcSuuCxqqMspOSy0zqwUyky+Ge19LMQKlcVHy4SxHb
	 l8LpGeWUD/FMZ2arWQASDebyG4JbkzlfpNFExS/9Y0N23PDonwN+nsqmGpNSuhS/VXA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794002262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YA9P0scr4Dgi1owZa6HFvotOnPqZE0VPMG/GD8Y11xk=;
	b=WRW2L5y8WzVMTfVb3yIZ8/vRotiB2TwAUJgVIBFFu6sxfsYlC5Gwb0GgTxOw2vxEuNxI
	 k3HLpR4Epad0md08gKcVOUkKFKjDqTkVeOvdiZyq17jC3dTatKLiPysKOZan0daHnvn7A
	 AtS8MxsCYBg15FuVXDXYmj1CxGo2PU+IOwOxbTy9UUCDTTIhvszqjBunstxlf/6BTtOFe
	 nJoguagaY1k/ZucZ7Ty+HhLRazp59hbSlQpMvpoJ5fjN/RUErsnA/dpsbEhLiUefYLxxv
	 c4FkXZeOwwJf827XiC9+cQkqqop3eLICyqkvBkGShQRTi5bzm9acZXe9Z8lLDCIsQqw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794002262;
	bh=YA9P0scr4Dgi1owZa6HFvotOnPqZE0VPMG/GD8Y11xk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lhcrfc4CQB2j5ZxNByyjpHMT2y1PiKoV4qz0N7pMbO93bh1kuzlBG1q+eGdmI+K87
	 GkBv70fXp4vmuwji9W/XXEjy1MdFtt6EudswjjWzPo2Tp85IdP1dE14tdkpfvFe9UE
	 x8pgr+xb6JLPAOc+GA8L8bLiS3zKXjb88BLO+0PBdWlmJEHFnbOUFoXOJgDGGe7utB
	 WVWXmeemrAC8i6XEiuWRkyPA7RrGosYefVchCIqiWr1zHRZMcQMQPcCYvvS06Qa5KA
	 CvfBqy3gbTOczkQVg2lPSfzaokfd77O1qKiUQPwxCs+exvuv6vzg1xjYUdGffKmB+F
	 d9E6XhReFoSUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 316FB60A59;
	Fri,  6 Nov 2026 21:57:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 314C731F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17332409B4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UniUZjqFu0jC for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 21:57:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 75D0B409AB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::233"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::233; helo=mail-oi1-x233.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=gNK3EvCQ
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75D0B409AB
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 21:57:39 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-5641f26ce05so519351b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 13:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794002259; x=1794607059;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YA9P0scr4Dgi1owZa6HFvotOnPqZE0VPMG/GD8Y11xk=;
 b=gNK3EvCQQYTm3FxJ4ePiy1uS4Aq2KK6YqF4CB4cygXycUxb03eqQxzdWds+dxM2Nb7
 bwheKk36iy1J/didGWnqOLKxKP8vVn8AuZtrUnQPh4ZF7eKthqjyfHdumPFtv1AsA/1+
 H8G0A4IlfVOMCKlG+NfG1NwT8SBkq3SIfuvexGLXVMLBwmE4245V5k9Zj6CP6HG+PIkt
 YKa8b1+Hc3siNf4MQsI2btN7z/SJ4CeelsLKqqJ1EAR7DkGS71qAD9Pi2Sw0zvz+znlV
 In4Z3/Qbf0dnZfqGbRkPxTrFWlAvKKzzqT5+eBrPzaO4PRVf3vWJCkF1F880ze7nhQNW
 GMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794002259; x=1794607059;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YA9P0scr4Dgi1owZa6HFvotOnPqZE0VPMG/GD8Y11xk=;
 b=bUoZ+jdeHz85gpnvguIJ11epYaHS8kGeSLe9CpEk1RvgZzma733ZwdBE669Ew45nZT
 kiIcvwwxUHp1U5JWHMpdNMydEgrPkU0DQGjvfXh9BhN/B6QezlB4lQj7brP66vYZUJ1+
 XSscgXE3yctzR1ou7iqXl2aTkiO/Xa3v6PJBA6L6KPZDOwZgyLYeMNKdcRlwPx+lDgwt
 gy2SAwTHMJzwU6nGO09Wc8t+t0O5ywAcn6FvM8INDPtGPTX4soOyO/bJd7kZhcsypl6h
 epYQLB7ia6kUHrF8vE6h7TzY2R6fsuc3ge/EQNiHspv0s/h413/DGDl93tft3IeCR5/+
 byCQ==
X-Gm-Message-State: APuU4Z+akTPJbkG0vfuQn/rIX+akggQ88yP6bqPdu30ee5tsaGpg0clm
 xYZkQ/lZoRG6jwB5Xk5oUDjnJRpJHRlwBxSt/zIsZcoGrLRcsPur9gs6EYw/IVQAq3naBL0z8rM
 SS965+oiUiGn0fWuZv6WV66XBbDHSax8=
X-Gm-Gg: AYBFou3dOCAjv22cY/MFPOSrBKWn0DBRMtiS0LK3hzz4LFjKVN2y3NDlAaJVRFlpcOx
 T3t+ljo/lXTA2Nz5fCCo8qgYl8gEMdSw0i3p6brz6SwCEUEBNY54/AmqsmZ/+OqnQ3oiP42MpTc
 0UPxOV7clQXQrD5/MkDHhzESwd57/3LEEVCIrFZ+ROYZgk17UPUzSKnhNxmKlQ0BfmPy9aj3Qs5
 b5OIVo1fHNLNtSy7j4SdMW6yAOXCSMIIGGlSSCNv3OAORDGcrKHaa+BWKZRW+cIazJM+616iBsS
 B1mk650JCmyw+569l6q6OFSByCvRaCXay2qs8utVAxtQffnjK3GaTgMpqfz62HxgGZ07/NiKJlb
 c0B5hnJmn4kaWyo4ow5vrP4B1KHArYcQdLKTj7g==
X-Received: by 2002:a05:6808:4f67:b0:4f5:cb60:33c5 with SMTP id
 5614622812f47-567e098c179mr3092575b6e.6.1794002258963; Fri, 06 Nov 2026
 13:57:38 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Nov 2026 13:57:38 -0800
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAC_iWjJg6aK1zy4ujOg-OfSK3Qt_NkTpgW3JRL08KaoYBTdzvg@mail.gmail.com>
References: <ad3fd084-d61c-44e2-980f-c978ca1e1dbf@gmail.com>
 <b509d1f3-50f0-4b3f-97fa-724862cc92fe@gmail.com>
 <CAC_iWjJg6aK1zy4ujOg-OfSK3Qt_NkTpgW3JRL08KaoYBTdzvg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Nov 2026 13:57:38 -0800
X-Gm-Features: AclHuK8b4dZghcqRLR5duz__xsuzBgVHydb83osvGthFqZG4FQ6cAbcXpYddlY8
Message-ID: <CAJnxHsi_g7FZeYokUfOycHv0aU-w7QE9w_mvHkGZDwXv+XROAA@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] efi_loader: check certificate lengths in
 efi_image_authenticate()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On Fri, 6 Nov 2026 at 14:47, Ilias Apalodimas wrote:
> The code you just added above rejects the < case no ? So with this
> we'll print something like "dwLength too small: 8 < 8".
>
> Also the new check is similar to the old one. Combine them to a single
> check that makes sense.

Yes, only a dwLength of 8 still reached the old branch. In v3 the two
are a single check: a certificate no longer than its header, or longer
than the rest of the table, rejects the image, so an empty certificate
is no longer skipped either.

Thanks,
Ana
