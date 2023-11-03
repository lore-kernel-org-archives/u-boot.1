Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2E0C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CA18726C;
	Fri,  3 Nov 2023 01:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OXU5oBor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BAEE8720C; Fri,  3 Nov 2023 01:30:26 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2821987596
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.cournoyer@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-778af1b5b1eso87001785a.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 17:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698971419; x=1699576219; darn=lists.denx.de;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uLcMZRPFnhuPwvzvEW1Srv4lm75gSFhYMxd+V/uKxPY=;
 b=OXU5oBorJ8dlcN5/FPuMgNpVbyhXDY5r8J/+HJ1dynLnSkRLh6YvBR1xYtD4BOKzjG
 cYa3eZEQ5baYzeOD3OFrNlTuworjLv3kiUgmmWoMBRrIo/vdruVbBwlbGmXonRMzY9b+
 qVU4rvX7tvts1JpiwJl78WdxM8XxlSV+tu9EpQxSpvgtRyFyBCl2grqQLcIgt7S86C9V
 a5BGiWuXYi7Q46Cmp7g1T8BYUiHRshTBIaYRNq+M++zuyjU6bPB8mUJxPtcy+rhFUtaK
 k0iJ6UlzftU6hyObRAHixLo378712cBO8wVh4sAiMGEKAf/Mkf2MXMH/zCUqbncAizoR
 l3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698971419; x=1699576219;
 h=mime-version:user-agent:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLcMZRPFnhuPwvzvEW1Srv4lm75gSFhYMxd+V/uKxPY=;
 b=nzPK55Z0grMUXsxDWAIsr5SO/xErLGDWnFz9TiWMulDbrJyVk34Dfv6/wfCLe7oUw5
 zYq7EODGS1wyXQFAcgsG2Nkz9b3kJW22FYa2wPzpNxWomMVSuSx06jeIqpyBVY6tZr1G
 6jgeThadMYIWdSu/DM2r1n4fz+8ujFxsLS+YEqto8RNFDVIxzUM7BOOOpVZnch3uYKQM
 ELp3j1zM+tDsd538SeplUt29JpJLD1U+rMM1v7u+vF67xZC4nQaFVAQBLPUoqzFud3X3
 zuL+ijFk4pO/2WCK5nrZ6HGRCLXzR05AIqtc7v+qanc0dJ/pD7uTmcGS2pESixqAvPCc
 +LyA==
X-Gm-Message-State: AOJu0YwecCecmQlKALAzhMOyGQODRe40MCtLQCFQ3AmmwFzy8xRRb7pv
 2Vav7DtOLRvENfOfoOB8WJcy7T+TG+I=
X-Google-Smtp-Source: AGHT+IFywaAVsce8NkyroY3Kbz7BTgIC1xokFjrpreAwkigbK4fycvgUEgMLTCQLeppoHJABPaNvKw==
X-Received: by 2002:ac8:57d3:0:b0:41c:bb5e:ba1b with SMTP id
 w19-20020ac857d3000000b0041cbb5eba1bmr25098892qta.38.1698971418651; 
 Thu, 02 Nov 2023 17:30:18 -0700 (PDT)
Received: from hurd (dsl-10-131-160.b2b2c.ca. [72.10.131.160])
 by smtp.gmail.com with ESMTPSA id
 y7-20020ac81287000000b00419c40a0d70sm206191qti.54.2023.11.02.17.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 17:30:17 -0700 (PDT)
From: Maxim Cournoyer <maxim.cournoyer@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] patman: Add a 'keep_change_id' setting
In-Reply-To: <CAPnjgZ2V0QejBkqyCB98rt4v7AZbuOp-cDHFy5oA0GBsXjvk4w@mail.gmail.com>
 (Simon Glass's message of "Thu, 2 Nov 2023 17:49:28 -0500")
References: <CAPnjgZ1U-EYeSbhQ_HEM0do8RhPBW_XgLUewXUTtWxnkOCjcAg@mail.gmail.com>
 <20231013011924.23877-1-maxim.cournoyer@gmail.com>
 <20231013030633.7191-1-maxim.cournoyer@gmail.com>
 <CAPnjgZ2V0QejBkqyCB98rt4v7AZbuOp-cDHFy5oA0GBsXjvk4w@mail.gmail.com>
Date: Thu, 02 Nov 2023 20:30:16 -0400
Message-ID: <87pm0rlluv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Simon,

Simon Glass <sjg@chromium.org> writes:

> On Thu, 12 Oct 2023 at 20:06, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
>>
>> A Change-Id can be useful for traceability purposes, and some projects
>> may wish to have them preserved.  This change makes it configurable
>> via a new 'keep_change_id' setting.
>>
>> Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
>> ---
>>
>> Changes in v2:
>> - Add missing argument to send parser
>> - Correctly propagate args.keep_change_id
>>
>>  tools/patman/__main__.py        |  2 ++
>>  tools/patman/control.py         | 12 +++++++++---
>>  tools/patman/patchstream.py     | 17 ++++++++++++-----
>>  tools/patman/patman.rst         | 11 ++++++-----
>>  tools/patman/test_checkpatch.py | 16 ++++++++++++++++
>>  5 files changed, 45 insertions(+), 13 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> Applied to u-boot-dm, thanks!

And thanks for the timely review! :-)

-- 
Maxim
