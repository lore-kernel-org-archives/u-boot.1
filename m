Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A5ECE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52335846D2;
	Sat, 23 Sep 2023 20:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Aw7HPGO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E3286B34; Sat, 23 Sep 2023 20:13:56 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F4219846D2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-532c3b4b55eso4725905a12.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695492833; x=1696097633; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oz4VeponaI+LLJEgsOPSVEKmupWx4l5xVXXcX35JAMU=;
 b=Aw7HPGO++PVzwhwZhPAOFOc65asy7WFwynfblbxKcRccZWWPtoBHzLrLqY6htNRKJ3
 3YHkHJyKxW3rt7DBoOiwYDErfsZBMQAsUw3svCXY98wFmEoDkd1ZOA1bu/rchT3MztF/
 k90mcZxLlz4ITs/Jz4FCkLtnpJbDR7O8CfrFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695492833; x=1696097633;
 h=content-transfer-encoding:cc:to:subject:message-id:date:references
 :in-reply-to:from:sender:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oz4VeponaI+LLJEgsOPSVEKmupWx4l5xVXXcX35JAMU=;
 b=ONvS2UCYa8cFiCg/J+P6JYCQ7468xyKbRJk4clXHiLZm7VRt6ruEh95CF8jW689hUk
 RZdgK6Y07aacfhmpn+Ly29nhMzCSwujk8YhbR6m36yioqQrNn+7MHsm5ChQMu70HQ+cZ
 ljq0/YPETLI16QCYho3xC7kAQoyCmHzD3McoIiVo67dXuWCNgjK2be5Mr9YyUjWEiM+z
 efXLlic6aiDkiUGNl9hP7jsQcdkc2TYylWFCoSlqom/sm6vki+PHaKbat4xdmvnDz/U0
 H6hBeA9Uv3J4s5Qkl7El0fsyG8BKog2JqfVkUPp9oZewXqSWFLP5nnYfo0Ft3DLQJw9E
 N7lQ==
X-Gm-Message-State: AOJu0YyCKjCEEMuSnUHJ0bLq1u54u6/LEWpckkfidq6UVTvkURbCFHyn
 shYGOCIRddsv6IwtaQYCwWrHK2lXAwveXXKpCKC+IA==
X-Google-Smtp-Source: AGHT+IFhzIhlHfCKfcMDc6FmVDtx52pwfz2eRUHjfInFmyr5npDaZruQyXJ/k2E0EYaqD9oIuETt6Y1AKn5jfbRJEGY=
X-Received: by 2002:a05:6402:295:b0:522:30cc:a1f4 with SMTP id
 l21-20020a056402029500b0052230cca1f4mr2392243edv.0.1695492833485; Sat, 23 Sep
 2023 11:13:53 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 11:13:52 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <tencent_94924065F3356E3401F1C54043882B8BFA05@qq.com>
References: <tencent_94924065F3356E3401F1C54043882B8BFA05@qq.com>
 <tencent_A957A85155C40E033B2189AC8CCB3995F607@qq.com>
 <CAPnjgZ1fWjL_qy+W4ygOvA2dDjK2v15zTJFkeNdqSSCDq8FuWQ@mail.gmail.com>
 <tencent_BA46C710370DF285E4B2EA2E35553A5FF909@qq.com>
 <CAPnjgZ12yLwPpo=8BBFmNOnz=RWykTtCzFOQyi11MgvS74QTcw@mail.gmail.com>
Date: Sat, 23 Sep 2023 11:13:52 -0700
X-Google-Sender-Auth: 195Ybx2AlUbOM6m0yOL88Noj2ng
Message-ID: <CAPnjgZ2hiG2jRGpq+930BJOyJk6htEnMP2Kfd=fYY+E6aTmXhg@mail.gmail.com>
Subject: Re: [PATCH v2] binman: Fix SyntaxWarning: invalid escape sequence '\('
To: Rong Tao <rtoax@foxmail.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, 
 Jonas Karlman <jonas@kwiboo.se>, open list <u-boot@lists.denx.de>,
 Rong Tao <rongtao@cestc.cn>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 9/11/23 6:36 AM, Simon Glass wrote:
> Hi,
>
> On Tue, 5 Sept 2023 at 19:34, =E8=8D=A3=E6=B6=9B <rtoax@foxmail.com> wrot=
e:
>> Thanks, Simon
>>
>> The following lines is my systeme ENV and make log
>>
>> $ cat /etc/os-release
>> NAME=3D"Fedora Linux"
>> VERSION=3D"40 (Workstation Edition Prerelease)"
>> ID=3Dfedora
>> VERSION_ID=3D40
>> VERSION_CODENAME=3D""
>> PLATFORM_ID=3D"platform:f40"
>> PRETTY_NAME=3D"Fedora Linux 40 (Workstation Edition Prerelease)"
>> ANSI_COLOR=3D"0;38;2;60;110;180"
>> LOGO=3Dfedora-logo-icon
>> CPE_NAME=3D"cpe:/o:fedoraproject:fedora:40"
>> DEFAULT_HOSTNAME=3D"fedora"
>> HOME_URL=3D"https://fedoraproject.org/"
>> DOCUMENTATION_URL=3D"https://docs.fedoraproject.org/en-US/fedora/rawhide=
/system-administrators-guide/"
>> SUPPORT_URL=3D"https://ask.fedoraproject.org/"
>> BUG_REPORT_URL=3D"https://bugzilla.redhat.com/"
>> REDHAT_BUGZILLA_PRODUCT=3D"Fedora"
>> REDHAT_BUGZILLA_PRODUCT_VERSION=3Drawhide
>> REDHAT_SUPPORT_PRODUCT=3D"Fedora"
>> REDHAT_SUPPORT_PRODUCT_VERSION=3Drawhide
>> SUPPORT_END=3D2024-05-14
>> VARIANT=3D"Workstation Edition"
>> VARIANT_ID=3Dworkstation
>>
>> $ uname -r
>> 6.6.0-0.rc0.20230901git99d99825fc07.3.fc40.x86_64
>>
>> $ gcc --version
>> gcc (GCC) 13.2.1 20230728 (Red Hat 13.2.1-1)
>> Copyright (C) 2023 Free Software Foundation, Inc.
>> This is free software; see the source for copying conditions.  There is =
NO
>> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE.
>>
>> $ make qemu-x86_64_defconfig
>>    HOSTCC  scripts/basic/fixdep
>>    HOSTCC  scripts/kconfig/conf.o
>>    YACC    scripts/kconfig/zconf.tab.c
>>    LEX     scripts/kconfig/zconf.lex.c
>>    HOSTCC  scripts/kconfig/zconf.tab.o
>>    HOSTLD  scripts/kconfig/conf
>> #
>> # configuration written to .config
>> #
>>
>> $ make -j8
>> ... [too much logs]
>>    SYM     spl/u-boot-spl.sym
>>    OBJCOPY spl/u-boot-x86-start16-spl.bin
>>    OBJCOPY spl/u-boot-x86-reset16-spl.bin
>>    CAT     spl/u-boot-spl-dtb.bin
>>    COPY    spl/u-boot-spl.bin
>>    BINMAN  .binman_stamp
>> /home/sda/git-repos/u-boot/tools/binman/etype/section.py:25: SyntaxWarni=
ng: invalid escape sequence '\('
>>    """Entry that contains other entries
>>    OFCHK   .config
>>
> Thanks for that. What is your Python version?

Thanks Simon

$ python --version
Python 3.12.0rc1

>
> Regards,
> Simon


Applied to u-boot-dm, thanks!
