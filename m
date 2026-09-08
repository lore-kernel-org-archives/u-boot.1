Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA464C79FA1
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 10:35:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 972B7606DE;
	Tue,  8 Sep 2026 10:35:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hdtnVPUPmPAy; Tue,  8 Sep 2026 10:35:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 74238606D5
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788863701;
	b=nJlXnMwPZ6kklR4yXYdObKtGGMlhJS0JiSIiYdRiGCbtILf5/G4tChfQtJ8cxltGo3eM
	 ybLHzeav5BZkb1w1TAEQsi4BHAecGLfK6ErPMfPwz7nJ0DvcnTU/oUyoTq69p/0v3ADSH
	 2RdobT/TLmmS7ZDvo3D4tK4WJ0ZP/iivegXQWJrk8EPyNXtjfJeibzc4Y5B0Kd91FgzBM
	 30gRAYSWT9InY5/dzl6Nds7H8FKDCV9jeAg6XnjuuxoAzZQN4aT78VDbiAoksmstWtTe7
	 zvbYv5e5cEQkNfIdyYvh/MzP47ns38YoxNhAHrwWeKPDrLEqFtD9E2E2q+ntw7ggxeA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788863701;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/xNP6sq0X6Smwkf3U8clA7sQhEk4Tlv7ewkLwu1Duo8=;
	b=qqGi6O1P+sG8/AKb4omrMHAyU8qTzw9nCDeGaigtUi3IpoFbM09hy1q44su4mUe6vKtS
	 55aasb8VqaJlCOvV0OZ8KZnrt2zOALuzsejtPoiQBf8vys+jsT/wuWW6Q8nWqOU1GX5oj
	 wmweSfCxgc2Wjd6hoaE0uyRojKKW+uDLeuAdDbn9xTzUkms8o3aB/TaQHvZdDq1/FmX4W
	 R800WkyViPTfyK9m4m5X/36NSk8IhtmDz1kAf7VfcM1rzQhYpHaWbDlVH2/y9pM88YNHj
	 d13G4vQUxzOLdS//RXoE/K8yIoxm5+MoSe3CD1Q8Vx5SHkbB1Dsh07waneXEBbmkrng==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788863701;
	bh=/xNP6sq0X6Smwkf3U8clA7sQhEk4Tlv7ewkLwu1Duo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LSkp8i0dX0ZXae6yK0rnw/7wM6mkdqwzSk7q5ucnxtKHZRERLYeQFzVdKqyyPsDpu
	 YgAztFIro080HQQo0/slgduCXwXSY6avKfqmmVMVlH5q4jW/l1GOgk8LkOyRD/BZa7
	 ri1hyZrPBhMT/OYijyatGsm66GZikHjBfLt0pzM3xkn+998UwtBYTetYWvx0++4Kvg
	 HILYc6wZ3P5BeTm4/aKBBpxLdfN75PM2fRlFML4CuLdGR8NgE78nvCumpQT8HpX0LU
	 51PK43Qfn1Hkse8ZKZyHLmAL5DQHzzG7jBXPTIxh49nVCZeHdLzGsG+2bj6iwoQaU5
	 hYsP6dwq51hvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74238606D5;
	Tue,  8 Sep 2026 10:35:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B0581A48
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AAD8F400EC
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:34:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y61OJFHM-zEQ for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 10:34:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 1278340063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788863698;
 b=Zb99crEjFEN50+X7rYYPrFZhjU9X2ykzt7HEpX3YVyJt5HGgwkObNcSAU5IcCW8ggOp6
 tKbdaNtJxZNhia+8Qk7aezN6WguL+lmAtilmyl4f0/qxkhEnlZbjMzZoNpUzahdjF8Dhg
 TktHm2nUysuJKcqfZdf+URq9gJRM6UXtD4jE09CdO80yRyy8Lnt6N3KK+QI/eYhiJWe/Z
 K+l71LcM5r4wmEq88GlGktH1gSj5uubNcaWIyap74JG1EC7nMLI8h/HjU4r+adReiV8n2
 KNurIQsQWh3mfs7USmymEDHlxWC2x38QdwQf4D6dYkSpBUL3et1UHmbpU0zJljCFiAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788863698;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=/xNP6sq0X6Smwkf3U8clA7sQhEk4Tlv7ewkLwu1Duo8=;
 b=rnJQfvk6M8q+WQUzFXv1CTJ7EjuWrdcbxQMCQq3fizBLjOwv1JX8G/2WFNRwm5odlgVS
 5yvvw7WxL2LW8U+Uawm+zUKxfI5PD0ZhyyYvPi9pM6uVnpdgoIAkaxWj9uIjiBQP/CnwP
 ERRrNTJzRkfkVuAYTcWMWvw2wyPlpihzXl4JorP5rOF4lVmSA3kp2GnU4ePAnw92dh+mg
 eS1Y80YyTIMKiaNzG9rtvRymK/oKPpxZsm+pXYLxI4GQTJp1Du1/iPDS10R2EZ745d1rH
 PWvxuJHeKVwwyHb+f1az0ozJEvweTcqNtFNc6lycBeDjkb2IFuWQ7nybFSUyVuSVAAA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Bs15sGP4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Bs15sGP4
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1278340063
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:34:57 +0000 (UTC)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7dbcb505578so41259667b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 03:34:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788863696; cv=none;
 d=google.com; s=arc-20260327;
 b=dZpsNzHLTLgqKZRMh5Hn/PaJMagZeW9Iw1uQbC3mpjT9rQLeKRfV4M+ekKtCfR7wz8
 mvUyDMM2ruZRqZhUxhfgh5PbHjU6NLkQAjo0cYZ63kIC8r8gUtmPhbhGljIYrA6Kt537
 4okjtDOEqu/QiUV1pf4e13c74n9Fw1I4FihG2xuLXjicWZ3A4c0X0FHAD5SChaC0ucGr
 BZBW7m5e4F11uGrDkBbF+IusFtcFfsTbiScLBELdaY6SVo2px+539WuzSluN/yIIVNWy
 96HCCWqWEYqgmNAl9MqKnh200PGDKZBwQfXgpZcMP0Vfxyx+QyJ0Z2MQjb2XzwQ6smAj
 x1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/xNP6sq0X6Smwkf3U8clA7sQhEk4Tlv7ewkLwu1Duo8=;
 fh=tNLf/+MrBZDRr7Ng5fSui9q2ZXbx1IfYZXPMDuKbLt4=;
 b=R50jrgcbS4h2Xh+zKtYCGiAY7WQpe2SMqb39dKo1fhh8RWblAz0XbCDsz9s7tI5fji
 zSE8HTesjqaJYzaSS2vlBxZcQjIfPhPPs/7yRSeXNZGyYSF2cZTxwwbIXk1MM/W4LRCh
 p2Ci50lqX3qDF61lY8nqmJF8rj6Rqjri1+YtITRDpw6bykdmBf/5IH6wk7wcE3kNyb1A
 X1bQw23PI6nGM+8eDDdAgFpEGN6d02nYr23ZKGWeYrhC7a53rmRCoL30bF0QfQpN+7e5
 nhJB3Q1htD7nebP6tjWKh2Uipt51dWt2ALjm0qipbbSkGrSAGGST4GjwgGVJuSyM9WH4
 ta9Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788863696; x=1789468496;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/xNP6sq0X6Smwkf3U8clA7sQhEk4Tlv7ewkLwu1Duo8=;
 b=Bs15sGP4i/4ksSy5GYhEAGMr8/n4bqYZ2tzsjX0w0npvfdFQZT7yDvzdJnfYpDk8jo
 VhfFXe7TSSjHHyXx1ghq5Yl4bKGuLRezIldFwfaYc8NwNcX92pnW6Pvf1Lp/64prVAKh
 XTV8CXmAz/8GS9G0MIaSTrC+J0MHuaPhnRsL1gH9QEnhrmc8zzNJx+q3lwa6U1Rc4LUa
 IXhaHcxi+yHeZB2Wv5IDx294Jm2Yh6g8o78xZcv2kkb0uBrvUKwXrC4JVNLiZlER5oB7
 9gGXoYjiaTn/RIyfTcRwYySEw0u4/XbWaj478DleAlr9eDa8Tkj6RtgaYJBvBXerly7q
 wt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788863696; x=1789468496;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/xNP6sq0X6Smwkf3U8clA7sQhEk4Tlv7ewkLwu1Duo8=;
 b=s9pZpekQQfVCARlCPnlxN46WQv2miYLJPPlYeGgjNnCIof17D74DmJ2MJbZptS8MWa
 SsHdkKzQo2sAUkx/N67mQJuqdNY5xzMwuL0TcmPhMQYGmKaXEp/laje2Rkp5Pr869SIW
 fd06HoTLulHyhTjp9K0l7KzJtFC8tK4LN3JyOfKxyGD+tqyDk1dcw4AAj7IKJ+P16W5S
 qF3TYF6EXQcAxxY/WBNlabvudAEI9E88VhmirFGGSv40WBEAXEp2m78LnWshyxY6W/XZ
 Bl3//p1xVSTZpeY4/3dE+USwCD0aTRJya1c8dewqCVbOwJnXlVqh4ZZWNX6VWafSZ8d7
 uL0w==
X-Gm-Message-State: AFuF++mSFVEIFQKn4s9V+YtCxB40HaTyxryz4dqVeoRD0CpjPBPdR9U/
 vpRom4qIbBWb8ThyKz1f1Lg3NqhD/91hf/UxyHsOKrUBGhGvGXJPD8V9WLdZ+/APdczsR2jJEve
 IUOBVmIoDRCgkxGghih8p4ooUD124fuunravM9yEm3Qfzoz/OVG9V4po5iw==
X-Gm-Gg: AYBFou2HRpc8lUImV7yhnIVWe0gdwt0Fzu9dMoPowkJzd6d0lrwekz1qgBclZmWph+x
 2BGtmtK3Db1x8+Xy+YXZxnjF7srIfMvwOt5K8sm5NxhhR94hjLubY1gmSwT8imJMkPwtPVjKFIb
 Wtvw8E2VApaTXUz4Kz6SduX+Ozp7v8to2XdkxkQJcyrI69uqGsps/GArCPoZ+m4WgM70vSilZg1
 RWQYOxd9LOn5o1IuzaXjNZwUf+dMcWGH1lpazsFRqv/QF34GrkisIQIK+3QwHr/TvhcpfLW/V7v
 NkUM98efuApZ/mffzbHKM0LtTnvbR2tWZkqESQXbTGnYesZM5cykH9GX8ZyDWlntcf6Wy3fgpnm
 r1Vauaq1S02UAJGMRN2IkZLAAp2oKuJxYUwNkCxOMe0Ms0WF7+wHXJSIQFW83eE0W1m5tzburqE
 FvKyzaWxag2GzD+1V3eFJJBdureSQ9XzdMJpTF0QtCqnO9XFAgWyRN+AFzLKywglPIRbcD3wQcy
 LSO79i0VKFjyJZcMmDubMp0XGUeT+d4+l+nzXFEV3lAgbsJYW1KAj8jzKpHedrwGyQPQ1sA4twa
 bDX5PhmpLWRcP9sqKURi6I2l+bO9SKX0LCGyj6Uzg/0LelNwFpc1yiFHcx9Ts1ZXPYMoHJX1ZEl
 UVKueR6PObiryrzWEvAiGEoOo2EVSzfUqWOiStRgNkpgw4h2lPdAqzA==
X-Received: by 2002:a05:690c:c50e:b0:873:5bb2:6c04 with SMTP id
 00721157ae682-8735bb26ce9mr64382497b3.46.1788863696256; Tue, 08 Sep 2026
 03:34:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1787514446.git.jan.kiszka@siemens.com>
 <70c9bcf676e253ed8c86699237c74e41c86eb34a.1787514446.git.jan.kiszka@siemens.com>
 <DL9QV3I7AB7A.3R0777LUCF562@linaro.org>
 <1084fdb7-2750-4aae-9d5b-d7102691101c@siemens.com>
 <6fb3ec9b-eebe-486a-9d62-bce5c7be0f57@siemens.com>
In-Reply-To: <6fb3ec9b-eebe-486a-9d62-bce5c7be0f57@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 8 Sep 2026 13:34:20 +0300
X-Gm-Features: AcwNN1VMoI2k7CDzbzP0WY_N3vUfZmY61lsWKAEfAK2p79CXgRbPk4_WSrxCPt0
Message-ID: <CAC_iWjK7VRXmYTaGCven73QY4ODHG+B25wjWnQMLAt0dWD_=uQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] tee: optee: Factor out service enumeration and
 binding functions
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>, 
 Alexander Heinisch <alexander.heinisch@siemens.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
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

On Tue, 8 Sept 2026 at 12:53, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 08.09.26 11:47, Jan Kiszka wrote:
> > On 08.09.26 09:08, Ilias Apalodimas wrote:
> >> Hi Jan
> >>
> >>
> >> On Sun Aug 23, 2026 at 10:47 PM EEST, Jan Kiszka wrote:
> >>> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>>
> >>> This already avoids code duplication between the different enumeration
> >>> commands. It will furthermore allow to implement a third one for
> >>> services with RPMB needs.
> >>>
> >>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >>> ---
> >>>  drivers/tee/optee/core.c          | 33 +++++++++++++++++--------------
> >>>  drivers/tee/optee/optee_private.h |  3 +++
> >>>  2 files changed, 21 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> >>> index 4d67c948ec1..2871760a7b7 100644
> >>> --- a/drivers/tee/optee/core.c
> >>> +++ b/drivers/tee/optee/core.c
> >>> @@ -156,7 +156,7 @@ static int enum_services(struct udevice *dev, struct tee_shm **shm, size_t *coun
> >>>     return ret;
> >>>  }
> >>>
> >>> -static int open_enum_session(struct udevice *dev, u32 *tee_sess)
> >>> +int optee_open_enum_session(struct udevice *dev, u32 *tee_sess)
> >>>  {
> >>>     const struct tee_optee_ta_uuid pta_uuid = PTA_DEVICE_ENUM;
> >>>     struct tee_open_session_arg arg = { };
> >>> @@ -176,31 +176,34 @@ static int open_enum_session(struct udevice *dev, u32 *tee_sess)
> >>>     return 0;
> >>>  }
> >>>
> >>> -static int bind_service_drivers(struct udevice *dev)
> >>> +int optee_bind_services(struct udevice *dev, u32 tee_sess,
> >>> +                   unsigned int pta_cmd)
> >>>  {
> >>>     struct tee_shm *service_list = NULL;
> >>>     size_t service_count;
> >>> -   u32 tee_sess;
> >>> -   int ret, ret2;
> >>> -
> >>> -   ret = open_enum_session(dev, &tee_sess);
> >>> -   if (ret)
> >>> -           return ret;
> >>> +   int ret;
> >>>
> >>>     ret = enum_services(dev, &service_list, &service_count, tee_sess,
> >>> -                       PTA_CMD_GET_DEVICES);
> >>> +                       pta_cmd);
> >>>     if (!ret && service_count)
> >>>             ret = bind_service_list(dev, service_list, service_count);
> >>>
> >>>     tee_shm_free(service_list);
> >>> -   service_list = NULL;
> >>>
> >>> -   ret2 = enum_services(dev, &service_list, &service_count, tee_sess,
> >>> -                        PTA_CMD_GET_DEVICES_SUPP);
> >>> -   if (!ret2 && service_count)
> >>> -           ret2 = bind_service_list(dev, service_list, service_count);
> >>> +   return ret;
> >>> +}
> >>> +
> >>> +static int bind_service_drivers(struct udevice *dev)
> >>> +{
> >>> +   u32 tee_sess;
> >>> +   int ret, ret2;
> >>>
> >>> -   tee_shm_free(service_list);
> >>> +   ret = optee_open_enum_session(dev, &tee_sess);
> >>> +   if (ret)
> >>> +           return ret;
> >>> +
> >>> +   ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
> >>
> >> Any reason we aren't exiting immediately here?
> >>
> >
> > Just maintained the pre-existing behavior. But I could do this as well:
> >
> >       ret = optee_bind_services(dev, tee_sess, PTA_CMD_GET_DEVICES);
> >       if (ret == 0)
> >               ret = optee_bind_services(dev, tee_sess,
> >                                         PTA_CMD_GET_DEVICES_SUPP);
> >
> > Simpler, in fact...
> >
>
> ... but logically different: We only warn if any binding attempt fails,
> now we would not even attempt the other.
>
> Key question is whether such an error scenario is possible at all, thus
> only PTA_CMD_GET_DEVICES fails but not PTA_CMD_GET_DEVICES_SUPP.

This can happen in the kernel (e.g the emulated RPMB that the
supplicant presents), but I don't think it happens in u-boot. However,
this is a valid reason not to exit immediately, so I am fine leaving
it as is

Cheers
/Ilias
>
> Jan
>
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center
