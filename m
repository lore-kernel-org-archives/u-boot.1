Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4738EE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 13:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B523B805E2;
	Wed,  8 Jan 2025 14:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y0/x3KNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A9E0805E9; Wed,  8 Jan 2025 14:54:03 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21AA78006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 14:54:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so2438974566b.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 05:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736344440; x=1736949240; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0edrhxKphjKjRO8CJGbC/gcdAivY4JBM7YcbNHx7bgE=;
 b=y0/x3KNV3dVY0jgvVxeU2wpCsDes5ujB9dkw5oYVQwFJa0l/yVVfmWpT9nJ4gBdB7L
 63KEOQQ2sVSNSp4jL7m6V4FsoX3d9S23KNWc5eqmyMcL2JElYOY535QABURcOX10h6Hl
 QXf2TPg1biPHIuDybfie/MkR9G9yezRM+K9dpaRaVhOMOYXNiTVIzXrFRtWi2Vq8nWbE
 h+GfTUrKiTOjdwhItKH9ps1/v1sMALr2o2VAQ6Q2Nc11Lfhnvc4JhH5qmGwSABjb8Zvf
 zt5PJBPeAFAlwR3st27EKZgCStV0KGI6WnTcSlDgLQG5QVhT1HSHjziRZooKgHT3b0Nb
 Do5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736344440; x=1736949240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0edrhxKphjKjRO8CJGbC/gcdAivY4JBM7YcbNHx7bgE=;
 b=syaA+9nNgihjNjJw7UMM3EUWQCuDGkcLgSRFZcRkuwlIQqwbsGdBRDo3Z5iF7HcVRP
 i2Bh1iSPEIZcJgVVe86Ia/8EXZ2f62S9zqGH5r5O0nmE7r3ZhTS0sxl6kF0nUSb9B3wx
 qfxSY+1ILmj9NoJYRcYIuy/KwoBHUtTIJbxm9/kfjhKipbdved/zG/Dvjj7RSSJVO2jz
 oOWboj566f9hobOF+bMy1o0MS+a+f7AvgvoOlzD8RM3v25hYs16zs/Aa7F6+bUTpIoeo
 Tyv8R9pThvZ9oHAZmcBB/cVJjKP9y18u2m7P/FkWrERkTwzixSZ45ZG5u3cyTHV1+0NW
 WrIQ==
X-Gm-Message-State: AOJu0YzjeFgA4jaOLYH8uT+KFIr5ZCmRUNq8r8lxnPuyhxgGF4IAp6cZ
 8dDz/hZmxvv6vfhNAQJM9TZS69nrjmkhKTEbs6luVt+HgvZ8KHkDb/+E3zmVPx8=
X-Gm-Gg: ASbGncu/rl30DUAwA0NF+0QFDfmXQA/v0kKm/M70Ng2MDduIy9UgNXLcXopspK/imco
 6x34mLUk9quZFaEqSR79Rh1RV7eqPmkGJj4itS52LXpNZMHbGKpfx3oOGkPlVgci3msKTu9kojQ
 TFWnQ0yo+/BI/MCb9UD3CoTD8v5p9GxBPSrArON8k4J22BkpaTB4pAFCGkVeY4cOvspT5CCpk4T
 OpJq4bYL1ar3AsdLrli54lVfhX9sE9C4AozdqFnHIe45Boaj0p5H6/5scGll15c+XgCY5T5mvuG
 nmMKiszb/cs=
X-Google-Smtp-Source: AGHT+IHhr5SKhVAJ0LdcBemFfbS09edHE/Cc4rV0tW/vusUG+MRA7y6RT7MSwbfPYwdd+wC1OausZA==
X-Received: by 2002:a17:906:ef0b:b0:aa6:88ae:22a with SMTP id
 a640c23a62f3a-ab2abc6f22dmr216609666b.37.1736344440452; 
 Wed, 08 Jan 2025 05:54:00 -0800 (PST)
Received: from hera (ppp176092181030.access.hol.gr. [176.92.181.30])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0f014572sm2480721766b.151.2025.01.08.05.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 05:54:00 -0800 (PST)
Date: Wed, 8 Jan 2025 15:53:57 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: Simon Glass's future with Das U-Boot project?
Message-ID: <Z36DdfO_EH454Xdw@hera>
References: <20250102161313.GP3476@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102161313.GP3476@bill-the-cat>
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

Hi Tom,

On Thu, Jan 02, 2025 at 10:13:13AM -0600, Tom Rini wrote:
> Hey all,
>
> While I had hoped that the quiet of the last week or so had meant that
> things would perhaps return to how they had been before, Simon's large
> patch series and then comments on the TPM+bloblist patch have shown
> otherwise.
>
> At this point, I do not know how best to handle Simon's behavior,
> without soliciting feedback in public first. At best he's created a
> soft-fork of the project with his "sjg/master" branch. I've asked him
> repeatedly to explain how he thinks this is all going to work out, in
> public. I've had private conversations with him, but I want him to

Everyone is entitled to create a fork. But as noted in another mail, he
can't use the public mailing lists asking feedback for his forked patches,
nor can he use the public infra (incl patchwork) to test and maintain his
changes.

> explain in public. Or, he can post the messages if he likes.
>
> And I am in the process of getting outside help that would in turn be
> able to help the project move beyond the BDFL model we've always used.
> Because at the end of the day, if most of the active developers would
> prefer the direction Simon wants to take everything in, that's something
> I can accept.

+1 here. As long as patches get reviewed properly we should follow what the
majority thinks is the proper technical direction.

> But what's going on now is towards the worst end of
> possible outcomes I think for the project itself. And by that I mean,
> one prominent contributor steam-rolling over others and doing as the
> please and implicitly acting as an authoritative voice for the project.

I personally don't want to pay attention to out of tree patches.
Simon randomly responds to emails 'applied to sjg1/master' or something
along those lines, which further complicates things as people might think
their code got merged.

I think we should wait a few more days and give Simon a chance to respond
and perhaps explain what drove him to create his fork.

Regards
/Ilias
>
> --
> Tom


