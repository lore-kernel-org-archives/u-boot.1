Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39D6CCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 09:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7327780F82;
	Mon, 19 Oct 2026 09:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2mNoCpNvRp2S; Mon, 19 Oct 2026 09:14:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0AC8D80EA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401250;
	b=XXiyffegAsAH5SGSJdqwAnhnJ/nvQTadimk8SS8ZLWX7YWx+tBrX1YZ0fCfHWfd6WRik
	 aBpZ/x1lk4Z0g45e1gTN9frxX4SSsdB/ewgajc/43H4cpBB1juP3OTkbECeMFgcrnvdPg
	 i6SaJjIbz23BPJN5BDTp5nr+Ym8SJVCPH1wy24+B7H+bX6UsWW0qfixlOJisZdk7fEYY5
	 UI7z7Q0kh8jW9DByD9eIrvUOTPW9PwE4ftKWWeA7C7M5a8AGoWUdG2juY/GXD7gCzMXkm
	 D00y97h9my4gwN/YE9yCoF503CyE2H9W6vajC8AISjFpOE67fVsHayvCeXVgY7zPUYQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792401250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZSRLhx/d9sUPdxvBtow4RU8PCBsrZYPbNHwsheRdbT0=;
	b=Qb/Pw0KiRa/Z08A2eeMAVs6n79aq1hjnhx7awD1lmbwt6L75wPNvUIe8WXmgjzaOhk7+
	 gKlT1aGG4FjlCnwgWMVC3tyL7mEnavAeM8Eh+ZdSlGayFpFqfudTdGXADCZYuz+aKoAd7
	 ASk+yT2Ct18ZWji8pY0ic/XRVvZb05Jo+8V0e61swDGsTuiP1zrPbwVhIamOIYrWQyLmr
	 qXmIiWhGoDC8WCMfHkGVOvz+ikR+R4KxVCzM5KHfvL2oLrT7E+4G0C55IT7iO6HFqqX7Y
	 Wnyu63Ym8ZgPwfpJY/4HlbSG/I8/0qcAZepshXHF74LN/x+RbG7fF1kghdgEFN3xPGQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792401250;
	bh=ZSRLhx/d9sUPdxvBtow4RU8PCBsrZYPbNHwsheRdbT0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JdsRtzLlef/R24dVKcQLyG8MTI4v783ARphcKjILidY3dnbmJg/s5WS++oi5YDPBk
	 8YHGc+WAIJlkYvYmVz36IGsHWtoo2wRLZO8/twX+zJkp2R5hEFSgn6KVO5d91Mm+Tf
	 OpIyKBLVbQA38wDeNEaHXYHqSA1xC1eFdScc4280ou/Q3G7EJIVIcRR83E27AzLflJ
	 8d0LNvnN14gw1+r12F9K711eAQVAK26yW1tVH6krWDJ8fY7TIWxT0zZRvL+sT2tRr1
	 xFveK8ciyHWWk5wT3vepkxb3oRABk1HiJjNy2W2K00qHSHfhd1teZ6kE+PG85pimOP
	 JEutzz6/B7J9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0AC8D80EA3;
	Mon, 19 Oct 2026 09:14:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D6D7823F
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C86824018B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xpxBMmtMijYC for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 09:14:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2EDC840062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792401248;
 b=SoZHQs6WvAyhKjGfPCqcAxuxpbAIehiOfezZzKVbUxUA4Z9GtnDMe4ztFr3kBEzAKv1/
 HvPNNhPd6zSP/XZtEYyPuK38Jz8p/kRjWco1m1olq6X5zhRqQ7QZ6eGN5zWP77W8fWYMM
 U4OX818o4EA6/clVqHrXi67tHLA9umhpLYUqwJ2XqI9iiIA7bGy6zzVywU4GD7FQc5VHV
 BA1fjpYP3zEIUdoYhZx8yUg5TbNvB1JqS8nSv/POxCp6SJaSaQXQgr2psKR808FAKR7N6
 0E27Ny60CIB0a+Y2E7U0r3VdKqkhgsPtMKgygae3pd/ap+s6NrHaNacjN4lRzI8yN1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792401248;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=ZSRLhx/d9sUPdxvBtow4RU8PCBsrZYPbNHwsheRdbT0=;
 b=cjnDQlFhxYsg/QmwNz/tqOK4zvissky8gavYsx1ZYSUsFVCu+eySLj0rNnCQp7SzPd+t
 kPpxIG1U82D8ICOMbENbExx5y2p+iTB8ehP0K7PaThZ5hXPeBSuxAggaK1ScUGPJU1yOu
 jM4CXanSYwqzwRE6pssGEDBBW6nrYMAojV9k/dR3XBdYyIxztFBW4I61KLBzM6AA6A/2c
 8r0Wuf1KcrX5EoUc6/EVlZpMu8kRVq4DhnNMAQRNcdtPLNo0HhuauzQIJfmZb9UBw8eJ+
 GTxKMpsMAg3TkTOx1CMtdbn5OnzalS1KiWzeKNNpYSArIZBbE2vp9XMog2XdH+VEMXQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=g9dgCB4z; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=g9dgCB4z
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2EDC840062
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 09:14:07 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so964024a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 02:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792401247; cv=none;
 d=google.com; s=arc-20260327;
 b=fgvtheOSSfUZUt+9VYJ1p9brCMR0JDLgOkGQNdKklPLQZhqSRNrl18udCYcj7IIw1f
 BSFpjwUtgvarSG4Jrl2whvCa35fSw706846iMk4ynbTVDhm2sE52prq/URAqhbbdYk6s
 KjCeKXCXA/2jLHgJeb7I3dfVogdPxrWVUxxGhNBM+USSnd+UGWCEcTKLkamcw2EJn+Kz
 slDuf4lSg/zuZiUsj4hlWBCQQ+kIMCCuHWhm2E+mPkZjsoC5oXd75ljMb1cYikhzwAyf
 aS2Tncp81+fCBCbKhRTGYipN9Og7pKIa2KEpt1DK01h4srhdNvt8mv5SY1fEvLmSJWOE
 JMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=ZSRLhx/d9sUPdxvBtow4RU8PCBsrZYPbNHwsheRdbT0=;
 fh=W9limZYOATxEysRzoYuLOospUaufMivdRUWM0xek0BM=;
 b=G4tNCVk1ARKAw8elzK7tTR4GTAZHy+BdXdCYSiUMNX9ufC0hRUAcTa4kCeMhO2NF/N
 +/yjzeU+uLtMfJ8BEQHuvC0JrTcjKubQG6WP5HQQ7wXUylDeGcZ8LnDqm6WCS0gQ+HN3
 V6lPabf0otHRsvsBUzb27p7nu4JCKofNUlfUrWxyQzAtnGNP1DyHdJgtoipbciXM+BUc
 oCB4TS44jB4NfrXWd5mbgBxUxdPU5sNmbTCXQMmV0kMeImgd9LbRIj8xgFsxeENa8AcT
 cc/WyX+p4SbEKMaMd4J/yldLnO9koip8NoSOrnmOLH201D4OX2IsktEhiMqmQwrL3yk8
 CEdg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792401247; x=1793006047;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZSRLhx/d9sUPdxvBtow4RU8PCBsrZYPbNHwsheRdbT0=;
 b=g9dgCB4z4N7zthBsmvKZWUX3PgLHkEadVlhn327RGtOYarNtEgpp5ALM1Vn6nFhLY9
 79qmpltk5iYuIq88441WzipUZ/wtZnOBCw1v9BFlFoXn2O8thfqY/N7CuwRtG4tl9CHp
 aPYrtRtPayu6u3+HL24fN2P7idsInPfrPny/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401247; x=1793006047;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZSRLhx/d9sUPdxvBtow4RU8PCBsrZYPbNHwsheRdbT0=;
 b=TBJvZgocSG6VO5hQlu026mPn5mtyhvbxI8VA3hEpQxWM+FTCOlZb9vP6A7gacNhPlV
 dsm8nsCCzHR2rlb0kaLPClLROVruKWxpcBJ17gI/ij/gjaK4OaiGztYjl26LiI+QJ1iF
 9ZVhOjC3wv9Szp27uAjpWJgBw6gg2MEoNSPJWPLpO/cqxT3Gu1Fl3VWwzG4bXaQBt0Jq
 b3RUzR1bR7YgBJv+55Rxn4msvZYKXteko2vBquhz1gpC6D0HaIdvoAjMsCE8mS/I5KGS
 zDSLZHIRtDlDmAYF5iy4ERpHyiofXVYdVhdLSrFRxDFpx5HkpYLG2KcRlWXfDoOIgexM
 uKaA==
X-Gm-Message-State: AFq9FYLlbhTxn4Sb/1p/Cms/5iIAZtz1mxUOOBZ29Unr82BYlpbNOCvd
 WxBs9xHlaubRUgvTZJJVjyizGlAocglMqQUqBLtkkBeQBmQaqZwdujt1fQbbaAzd+QLFwkTi9hZ
 XmNTMqYIxgMp4Jj8PS1m09c8V4Q8y/FIyubFhZqPQ1HZIUcu87v0ebA==
X-Gm-Gg: AYBFou0M3D3MtqsulC8P4Xb5sngpsR1Z8nrK/EnYRvmTh58T2kDQxruvKeiJVUoYFbL
 kt4auMh/ffJg0hNDAKGD2ShPT8LmfAKBupDk2uaIEnPtwSJJTOKr8WHpXOkEKxLmfIloUSiOEHP
 0OpOCGvomXKVrwZ8w17ZJs/nJFHwT10FL85fk/j3DR8RkaXdhUODjH8Bd4WWA+HZcSkTaXU6YSx
 ghYGdYnRWo/a1dCRXc7uCSI1bmRfeEdARI8DOOmwKxp6meepKssGU+DwsbDFKKO1XM8Qq5Cv2zt
 aUR9/zmc9MKi1t2WQT4zI6bkMoNsBAQxXXtiXWa6ELO9De3oHazTOaccJ3hkDFVydQ==
X-Received: by 2002:a17:90a:d44d:b0:3ac:8b67:185b with SMTP id
 98e67ed59e1d1-3acef29e7aamr4175578a91.26.1792401247109; Mon, 19 Oct 2026
 02:14:07 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 11:14:00 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 07:06:57 -0700
MIME-Version: 1.0
In-Reply-To: <20261017-b4-expo-colours-v1-4-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
 <20261017-b4-expo-colours-v1-4-479ac06e7642@protonmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 19 Oct 2026 11:14:00 +0200
X-Gm-Features: AclHuK9kebpv2u08OKFge8ZMI4QgMVRCwwtpdss57Q4z4O9z2TgOi9o8XPMd4lQ
Message-ID: <CAFLszTgiqa3vkzKUSq49XvSw3JoH_-moF4yve4p7eX8s2h3ohQ@mail.gmail.com>
Subject: Re: [PATCH 04/14] expo: Allow menus to wrap around
To: petr.hodina@protonmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>,
 =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-17T09:10:23, Petr Hodina via B4 Relay
<devnull+petr.hodina.protonmail.com@kernel.org> wrote:
> expo: Allow menus to wrap around
>
> Add scene_menu_set_wrap() so that pressing down on the last selectable
> item moves to the first and up on the first moves to the last.
>
> Move the search for the next item into a helper which also skips
> section headers.
>
> This is off by default so existing menus behave as before.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
>
> boot/scene_menu.c    | 53 +++++++++++++++++++++++++++++++++++++++-------------
>  doc/develop/expo.rst |  3 +++
>  include/expo.h       | 14 ++++++++++++++
>  3 files changed, 57 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
