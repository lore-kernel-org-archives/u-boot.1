Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52594C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 18:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9F3E80BCF;
	Tue, 22 Sep 2026 18:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t2NjFGzSEbTZ; Tue, 22 Sep 2026 18:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org AD04380BE7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790102238;
	b=HrdeegIEzK8KeecCowVYlg4RSB3gHk5ZI60Z+Y1KecV7t0CeYwJ9lB9NACnrNVAhAnqL
	 OAq16/J9r6Xeb9i/QC1vQMmR/zu18hurcQ/9YTOzKvYvDUHX9KxtBL5ufNW9UKyqJREZ9
	 tkNoNjuHDVmnXhiVVaqosN1CndQRwG38pdBYw8a8sJpeRx6I6qs4KCODp32hYv4ADaZLH
	 kZpLmMc/hAD6egcfyDNqNVQaqVjiXQ1aOjxPrhkFtV/jXPs2PdWvMGZnVEaBxwG3dKmiS
	 5Y7T01j3WBEvC77YwY8bt4Rl3cy2ET4xqLU9c/ItCdFnFp8B7gPK9zDrybrrRaFB3+w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790102238;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NJbGZIyRXYzKS44VVSWwpEvkPlUAa9+r215vermmoR8=;
	b=sMEhOYVdS30LFU2XWKW+TFAyS+MsA833nyjXotZ2JPw5bqrVP72CY4uQ6w8rwxu1CVQM
	 NE4O0M0G0qejDeWMOFlgsZyUwzjeevJ73tf4lHqHqpszVr1RkJm2mSLpaqETWcx2/WQkJ
	 NnF140BTz5mj8LMC4PJo9+6kkDL5M8rIBj42SHF9B+xNaR8dd0n4gMxhl96KpJ0xDYSy/
	 xgtpHrGUwLl9EVXisKQ9yhOq6WU1bWa3Arq8EvalUkYS+mu2QGw7/7RWG62bASEpRfAhH
	 Jmooqrlmx2zIgFiKYF/5oQQql0w+Y7uzGT+8Rz6SI6giqCpa4Nm8Qf4J4QH7gKrvXgA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790102238;
	bh=NJbGZIyRXYzKS44VVSWwpEvkPlUAa9+r215vermmoR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wpKDJ3JRbxlACYs4bGFkpIycuwgR8aLlp3oh3nHItbl9Sk2n2dgbtldZqAAd99YFV
	 pNH+RNuyrAEmNmfe1bI7il7lLwL2jilj8WQfVG6ffCE9e+gIbonHze4iWWYD4g978i
	 RnfzVoQfXQUNAuZ3aubY0WsdDSwjkjCpZCsUuIXOodBGu5hwpkeyOB7/qHzKdWpIXL
	 xmQB2fE1M6h+xaTTozRq55Vo/kLlKmIDH9DRCzYAIU9F2CmJp2qMCIud9EP4Jofb/5
	 gFzzrPEDcQ6Jw1xfk85ztahie1nGfowj89sm5APJEUss0oICv02OOPd4+i36qzpQ0p
	 5tujMXxNkbKPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD04380BE7;
	Tue, 22 Sep 2026 18:37:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9455D1
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 18:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B2D94080B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 18:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EAfnJfcnmAZ6 for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 18:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E3A43407F8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790102236;
 b=ZGdHq8FKWoJjgBlkefkEJR2bef06tFbZ+VOL+7I0AUOvLS67a/FWr4bhEyhA63S+RrIb
 hIrasG4LiwgpnB5VotGTfQCMIQsse6h2a1/Nm8QNfNlypFrIDrUnc7OBUUx/NT+QRWa9F
 EHAvvuUNvLxu/Z0W6y6IW3eHL/9oF9aYLRHrT1pMIyjInLh6ywHisiqMlaNUSMrVUj01x
 +DrTR4Ry7zrHuDL4TdyTBq23Ql8DUVRPIqFXLeviFAmWjh4Za+suO5wM60cl8M3jLdZNk
 da9K7zjYqUPJ/BpvWKEThFULXfYQra4f1GpwmU3cOHz/GnWe7RaH19V9p3nnXfeQXlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790102236;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=NJbGZIyRXYzKS44VVSWwpEvkPlUAa9+r215vermmoR8=;
 b=MZuO6lKfkWHg/tElBpJK7PuhjazHZym6DO2X1fIpajbe9RP300nImgYqVCyMqJxJTmWe
 LjQPsqhkd91wIbMHaFrYE8gnbJUErflZNvtAMQjpssOkQYZ7CclHkshGZrkF19me1jfhf
 TeAfTlglk709P7ZQfhGNYbm9ApQwwM6pd/TyfFlO8YUonTLHXslcByUduwhkrdV0tS8eF
 RwwFWoa3LKVZ+MMtMUqNkmi5hj4GZLbcfK1QyWF5JKmANO59nEEy1coshtxpjGlRtvL1w
 9ZswH3f0gZZPZCNrDmL1Pw3EUnWGVdwZgVa/VYpfnrtZA/8YV0cLfCAaU0MhY0DDjvQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=oss.tenstorrent.com; 
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=HM6dXQ2Q; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=HM6dXQ2Q
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3A43407F8
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 18:37:14 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 00721157ae682-85d43f9b120so4208127b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 11:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790102233; cv=none;
 d=google.com; s=arc-20260327;
 b=YlwuHergPlRANC6M7HY0thqwLlf3DLshftkwj+GmRnQ8jvOPfNuc1CDYk7oClWGtj8
 bcxs52wyPmOoxHLmwua04qrdbc4uskzyAC2uh+HIkQ2QaN2Sjs9fiNa2k/7FcUheMJDS
 QYiiUe8VnmkqBxC/W8Y2QjX5Hh+A0ko2kQT1oVFstUmV7zGrXR7SixkQoWHvj73lt3zn
 GnPBbhRzJ9v1hJJBcadkTg9OAC/2NjiH/XYgSPC+2haoLjdgC29ZVIIiCCUl6b6JmLjM
 JnupVcYPEsIvbiR6weyvL/bawsQkh4nZG1bXKy7PF71oLO0UO3iTovbgiSfcxYacyzNp
 DWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NJbGZIyRXYzKS44VVSWwpEvkPlUAa9+r215vermmoR8=;
 fh=A4rxwYmAcwfDXy0yZ4N6RjRCaGLs6CZr1L3u8ei83NY=;
 b=Ms33AwCnzZ6jdQBAdCN4gYSie+MLZwbXfXENg5r9e63o+tEDvn7uDA8Q3sGfBcbm6p
 V3cnxkrDhYSN74MKJLj2yk6VMlnyCWIjV2yTmN7oH2TszgTmCTg9/q5h2CYaUO4p7la1
 Oh2qDSr3NIvrbUUTyUWQALKx2Yw7L4NDCw99W9wPXb8TjUO3qUTtR7QGZA38Giq9Ods0
 VxVf4vRe6D5mwItCQGabN20n1q80iuBXQ7XxS23dmh+kOOX2j3RfYt0lQl3IrxAJTzTL
 MooPfFPhnkBP0c/lstsl1de1hME6ImBB19RuDnRq+osBg97u2R7wRivu47cbzLX4bLe8
 tJPQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790102233; x=1790707033;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NJbGZIyRXYzKS44VVSWwpEvkPlUAa9+r215vermmoR8=;
 b=HM6dXQ2Q7S6ajnE6izlNj1JIJo+jrDDIvD2Ma5nZPZaeODMg1UmIK1EmlAYdksOCMf
 ZnjGz35uVOcJFbXldFWFKX/D3wtxQTP1o3OBNFQ3uvX2QRRZh0OK+edKQHD9CLLG0q03
 7AB/R3PHPpL2WVVbaoxd2mMtkVXK+SIx56UKMXAV74B53/x8+YAyenfaMwwb7bJSNfLN
 GeRPoLGY2F/7BX71Q1gz19m2/GKwXJTbat55/A5Cw2FRRpWoLP2vxi/uZclQj4HEh+vl
 2fBg61gHNw6GDB7vRAjIeDQPbcpZF4Ii40H07hOgrPqULaEDEe4MYqpt3cdvHQX0QBqq
 K8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790102233; x=1790707033;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NJbGZIyRXYzKS44VVSWwpEvkPlUAa9+r215vermmoR8=;
 b=hod0GjpgWqs7A9xCJtslZ/P/uAZRODBygY9YwfQDCdtfrZv3tM9K4AZrYVN1GEwqgD
 KE/V+VNFBebylajYPPqzTFeHh5psC4bHW6EetQ8bJdn5AUJ7jZYp8IG+6HExKug0ftYy
 cZvvHpc7CCvT5p4QjJKWZqNbgNetDNDgMcmHKsYA/gruYrFFV7gSCvJUQsbh8mHLEBCg
 v2v25dNMs8PVOPXFVccue+fTBKXXJaxk3oOwu2Gtp/Madrfl3UYiCKBa58AEPj7Ij96B
 sob0aQz/aw+mkukUPvDy+eTRdMS0OY3JWgWQjc1LPVJrsAS6i81YOWgoqQ0ty9rzWmmB
 ctZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlJ3JCWPPzCQoptojaTx/QBjHk1Vq2Wdy6VCkcmFsArWT01L0X/MWKxde9GUcAg8k2UTwlALk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kRzzPHZbomDeezxmj8q8udtxsA8E58jy4xO34vFIMrA2ElCrTU
 FAI5DcqwWEjMsE+7MJzJ7DaA6sQngplbvfNSkATo/9lKxwIS2jE5mdyfP6XGZnTXRwrz08VTESW
 HeFBwy1G6JKSCZO93qXIsAm4Lj33q/xR8sgu/YYqkKQ==
X-Gm-Gg: AYBFou1E91H/huZQocUY95HRMhSMZvBZrZn/bceuY3NIQbs/7VsgDytWq/aQuFCMqUF
 LjZcIBDdxJYSB0RDjD82oXhwjY8TkhsHPjEBhPWdbc4swiIuLXR2Dx+CGYgJgfujWE+KR7UqlVr
 Lp7mzsJeapVwtZvFiwEIQeGRcAsKWhPwVqENWFh4eW6FMImBFHyjL9PEmU3NnQ7l6UNzTbxBrhe
 kJUmXMETfmekDFD4aux7/0arPXAksA3owx7xuJobdRkZ74/pHeGA9py2nDon2B1HcMCG8Tm30wk
 +rA3Bmq/jQ4QQ6cLfx1JxY6E35OXOTftY/xzPJW4VTH+3zQw1yUXxGCfAH+jr3VfIdXHmNtg4Hx
 1BjI2f3w70TN07FnJK8zz
X-Received: by 2002:a05:690c:60c1:b0:873:5ddf:d865 with SMTP id
 00721157ae682-8a4599fed75mr2591847b3.48.1790102233267; Tue, 22 Sep 2026
 11:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-riscv_iommu-v2-1-e0b816494b1a@oss.tenstorrent.com>
In-Reply-To: <20260825-riscv_iommu-v2-1-e0b816494b1a@oss.tenstorrent.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 22 Sep 2026 13:37:02 -0500
X-Gm-Features: AcwNN1UWjcu56UZcOgp-kLqDbwwWcfIaBgBUFk0etOKXFZ1LkEgIVYZ54tgPaeo
Message-ID: <CAEev2e9WvQD3ZJNU91-UH1p5KBw1zXZgqhJuBC+6y+Q9HvwrwQ@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: Add RISC-V IOMMU driver
To: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi,

On Tue, Aug 25, 2026 at 11:43=E2=80=AFAM Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> Adds a basic driver for IOMMUs that conform to the RISC-V IOMMU
> specification. This driver sets up the IOMMU in bare mode so that
> peripherals requiring DMA in U-Boot can function.
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
> Changes in v2:
> - Changed DDTP read timeout to 3s from 10s
> - Link to v1: https://patch.msgid.link/20260803-riscv_iommu-v1-1-793cfa42=
1ab2@oss.tenstorrent.com
> ---
> Hi,
>
> This is a pre-requisite for U-Boot on Tenstorrent Atlantis. On this
> platform, the IOMMU comes up in Off mode at boot, so this is needed for
> SD and NVME boot to work in U-Boot.
> ---
>  MAINTAINERS                 |  1 +
>  drivers/iommu/Kconfig       |  8 +++++
>  drivers/iommu/Makefile      |  1 +
>  drivers/iommu/riscv_iommu.c | 82 +++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 92 insertions(+)

Gentle ping on this.

Regards
Anirudh Srinivasan
