Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C42C56205
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 14:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3C6680DB5;
	Thu,  6 Aug 2026 14:53:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vfz-WwrP2A0x; Thu,  6 Aug 2026 14:53:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 079DF80D5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786027994;
	bh=rLh9sPh1WUefnKm/LbIWyqMx1iAq3cSGzX7xB1A8M6k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VuA/I5faC8QqXuWx9qwRfixT3lhzawC7xiyo2y5c0GJZ58l9rbIO4HYpkDjnDwuGI
	 SwO1I7A+LNiVHyO68MH9+kwin81GjEG8/9ZVypZb9JRmuA2DuLVXUiQ4xuWbkoUvVL
	 vqZxcl66XYCtFf3HCsCfZQcIH1WUTM6g4fxlJqpDGixz1XZu0AbuW+r/RSRqPrIn+M
	 44NDuzMq0qSoHUtwagWP2ryFm8fm9k+33tscTB4JPBh4L7AxmBhP+FBs0cCezCiNOz
	 k6rqs2obX9wX8kJrDKLp4AS0ZjV3sZGC1wBKX41oEP5SzGmXxYG/Z50JJDvlr2RfT3
	 TnhGRKP3DlYDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 079DF80D5E;
	Thu,  6 Aug 2026 14:53:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 515EB194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 14:53:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 42B6440517
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 14:53:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jlipXOUuI3YL for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 14:53:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F30FE4050A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F30FE4050A
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F30FE4050A
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 14:53:11 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c2055f5a993so130398266b.2
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 07:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786027990; cv=none;
 d=google.com; s=arc-20260327;
 b=lURDb3UGnr1azabE2Fhd0EomedXyfSQ6/NkxtPCv7e4YOA4lzAIPa2/m5s72crsDjX
 h+3ShpdxbHb1I6p/stjnCCm9rj9s+Yg8nOFSJ2H9ukHX65EZVLOYKpwcOLeWKdwp7IdG
 VTUJmdhhBzkFpUmFK97BurVQnJcaWAjeSFgkMtli/RAcMYBWukbF+7uNvkQ0F0bDwUFQ
 q1geW/K5mv1te/idZjnytYuIgZnsXWUrbGTRLOSFPVpjifCoZJtIjhN6BhfaXTJhnqM/
 65QL8UH4c3I2X0EgwB1Bgmcxr48lkPHkDkXGdMvHFLJBwC4Vsh6aP716McV2EO/ZzQhU
 oysA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rLh9sPh1WUefnKm/LbIWyqMx1iAq3cSGzX7xB1A8M6k=;
 fh=esTGa2ceWY5BQjynIU3BTJtGQYEQTsY0X3D30tNVLOI=;
 b=JOSNTV/v+RXw2C7nwCS4X1+eFf7sl/lR9FzLITKdmB94dBRt1mAhIcFS8+P7vl2OYL
 SvV7fTHSkpyW/eJ1LCnsgfWeY69+rAGV2ABG9DBqEK12Z7sJgST94mTEZUX5WwzsLlxx
 M5pU13oaSiOPUlQMDfXJNB/PYIFes03ScGS/4cOhGD0uqhA5iMQhVRfPFXRE/7aVi6yt
 d+Z/R6w/b2ZImGgmIvPnR7jEYaIPn5j0CrqeDdIRJ16kSDkAfiU3yY0Y5cDywL6XyXys
 UKJIpZtHt20oCrKXBL4Mxxaus9x2ZYzSuKlfWxlKb3fHcdQHpbxm7epCQRKmXv1zc4C2
 HFPg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786027990; x=1786632790;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rLh9sPh1WUefnKm/LbIWyqMx1iAq3cSGzX7xB1A8M6k=;
 b=misgsTarmjggNwugoKbRjtrkZvD+13Oh/OoILdZgQig1ovM1a7r/vlPhxqNgMbOFwZ
 i0ypyR81ffcep5/aizBRMa2ue05gU+1ba96VwdYT2bA0kQmCZZd8uyzGTeaYmiplft1Q
 MBhJqVVJHoW8C7nZ6zfiBKbnsSaosfpgJhKO0T6YY7NpbwtN4b8Rkk8FvMQv9T4cM1IF
 J0jrrl2vD6Bunqf8yIuIpVQRiZy4o5AGdJhDSqSW2UD2Ldo8MztxgTPCE0kUJoj4IWQ/
 /o8j3MOxJT5LWc0oSgnVuLfJSmbwESdKPP93J02u47XkmBeIrUEHFN/fB1rgmFy7tpM1
 GBig==
X-Gm-Message-State: AOJu0YzFompRFLHVM5eu+OVz0QJW/j6N9XhTD1uDJS3nLY9/v3kmB21o
 12/qghXEo9XAVBdPJZlft2cBHoRAT21M2kL8br9JehXy05QMV1ph5LktDbc2HrHqW4iCWvdxlCQ
 e++yCEwNzeOUlvDd6sCbzDxW3PyZBovsmQTOalV3N95s9Rm8idvI=
X-Gm-Gg: AR+sD12uH5gVAEFHPP/8bbyBBTUiDbupYYgH7jqmIxtdGppOxVcVnSHzg0D/tkJ3Ss2
 GCO18CL3gVnoGxc/gzGBuvNeleSng3fgsEV23W0ILKfC9ra781SkYwc+4qoBzUY8rcWAb4GQnT3
 tE4oBbYxvZEgY4f11kIfGoHQcVv7/PP01TLWB7dhhEos5LGTYKe5va9/bC1OyVzDb73ZAJfa7nU
 LbC8b2U6qTZv9kuET/mEAp9Bm3J4LgXkpaY5VX0OJSOXOQ2WVB/36YzJFeUkYDKNuFxtKxSaqkq
 n3xgmq9uZpZGnD+ijk8HQTzJlnsWE1SkpfA8swUuoP0=
X-Received: by 2002:a17:907:9811:b0:c1f:e9d6:2a6f with SMTP id
 a640c23a62f3a-c20397f4aa5mr872914166b.0.1786027989708; Thu, 06 Aug 2026
 07:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <39fb1908-e2d3-4d3c-af94-958bef35dddc@adalogics.com>
In-Reply-To: <39fb1908-e2d3-4d3c-af94-958bef35dddc@adalogics.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 08:52:57 -0600
X-Gm-Features: AUfX_mx_c0cuRebAhB9Q4nvMNa07P0e33AsgTZhNlIfkX1DOGC73irLdxIakj_4
Message-ID: <CAFLszTjWPVBmqtSyOTBG-5qQ+xCmJ+w=vwoX2jUepEvFnZMtAg@mail.gmail.com>
Subject: Re: [security] Report of possible heap overflow in U-Boot's Android
 bootmeth before any AVB verification (ANT-2026-ZWED60S8)
To: Arthur Chan <arthur.chan@adalogics.com>
Cc: u-boot@lists.u-boot-project.org, David Korczynski <david@adalogics.com>, 
 Adam Korczynski <adam@adalogics.com>, 
 "security-cvd@anthropic.com" <security-cvd@anthropic.com>, trini@konsulko.com,
 mkorpershoek@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786027990; x=1786632790;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rLh9sPh1WUefnKm/LbIWyqMx1iAq3cSGzX7xB1A8M6k=;
 b=mbqEqdb7QsMdIITyvNRP3FqmFN1kfcwoM3JYglRohLBrfLoclw5ffXy+uLU9t4K94c
 UoJ8DkuH9DCZK3G00CSWoveCJOO9/dMQoM+3BSb4ag0l8eA0wcHr5I7PXR8YFwOd6864
 BiqG4Bb+zOvqN3vWsrghLJezMa8R0QxrpEW3M=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=mbqEqdb7
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Arthur,

On Thu, 6 Aug 2026 at 06:23, Arthur Chan <arthur.chan@adalogics.com> wrote:
>
> Hello U-Boot maintainers,
>
> I'd like to report a High-severity security issue in  U-Boot (https://github.com/u-boot/u-boot / https://git.u-boot-project.org/u-boot/u-boot) related to possible heap overflow in U-Boot's Android bootmeth before any AVB verification.

Thanks for the report.

>
> I have attached 3 files with this email as described below.
> 1) report.md: A full description of the vulnerability and how to reproduce it, together with suggested fix of the issue.
> 2) Dockerfile: A Dockerfile for demonstrating the issue.
> 3) driver.c: Work with the Dockerfile to demonstrate the issue.
>
> Attribution
> -----------
> Please attribute Claude and Ada Logics. This issue was found by Anthropic from using agents to study security of open source projects, and I am from Ada Logics helping validate the found issues and creating the report manually and notify the maintainers.

If this is a standard text, I suggest '...issues found, manually
create a report and notify...'.

Are you able to send a patch? Then your attribution will be in the
source tree :-)

Also I suggest avoiding HTML in email to the mailing list.

>
> Disclosure
> ----------
> This report follows a 90-day coordinated disclosure deadline. I'm happy to coordinate on the exact timing and to provide any further detail you need.
>
> Kind regards,
> Arthur Chan
>
>
>
> ADA Logics Ltd is registered in England. No: 11624074.
> Registered office: 266 Banbury Road, Post Box 292,
> OX2 7DL, Oxford, Oxfordshire , United Kingdom

Regards,
Simon
