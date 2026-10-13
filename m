Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2CBCC6B0F
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 13:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C345960670;
	Tue, 13 Oct 2026 13:37:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ghjz5I_kKGcp; Tue, 13 Oct 2026 13:37:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C4430605CF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791898638;
	b=KGDjZbB9yQQEovjeCYnQgXdZjGF1VO/2XBpE3MxaPQ6jpWTabwYL2mNC++viALk63Xdj
	 8Ir08XZKNPZmq/hLY2JU86PeFOV/zOwGENczFjhoW4Qz85KLxCimWHXVy66+TkID1zlBK
	 HbA2XhtSJNUwhU97rLy9/KrWnPAg5ejzbQap7p4O1K5ZLb0DgdmO9eZDDk5585T95SjtQ
	 CEIqXrV/STkbXxFYeI6UCbh8j5057G9WDJSLW3hISbVTE3tr4Bu8LNISKXmf/ezDov8YJ
	 9VAK8QDfKqkJq4JBDlmXNz7bXfI4D8IEwuYLLoBDSeLS1SGqnBcHHFR5gLGsUjLhKSg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791898638;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hFdJd8GfAelk9wTmHIhz1RuNjSzBr/se8qjop3jJIzA=;
	b=tKFyj9MgPRlXJnw05tJjL4plBjw/54VsjAmW6MgXbJujBkJ77arcomMSCJMwC85CG5sv
	 jOI/9kHK01uICbsIrC12xVLno/1fA01/+YU6urc7cD676ky4BgfjU+swUtB/rG7bMwjbT
	 wApTBiNnp8wEqCw00waULykzFAoUQKfLplQzkDmlf4/c0g4pi0B1nY9YChKWbo6hVtv4u
	 oFUSl77vydMCVFrLpLYjxlodgtevvOar/SiKW26N/tqsHamZMRqtL+ZEDRRut/6m/Ii3k
	 G9vGTPuqTREDH6gkb4HMmCMlWjMiZJcBIjyqFqPSwUYxyQv1/st51Zt9XSaNkuvwuDw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791898638;
	bh=hFdJd8GfAelk9wTmHIhz1RuNjSzBr/se8qjop3jJIzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wTEXDpCfAyv7SD2Gz745xey839vZPUnmDsgJx9CWvk6U2SQ49RK5qSH5mFJVdisI8
	 eNT99GTPCyK77xj+qX6QrR4teN0v8SMXhTFnbEDLDp6bzhikQELK8+p4AybgN8RgEt
	 SMGzvQknNPkVN4vpvLOYAI9buRTRo4yjuwlXEZxKrPtIzQ1ODlVDcdfeWehMNIeYQ9
	 LivX51MiGYsF2OEABHCXd5niJqFhukvGouoOMZVDR/6O+f2DLe0B3WKuAg0de926SD
	 bGxLq3UV5fcN559PUM3NuNveI9unFJ7q2O4Py2IIotkK3I0P/2+607Oo4/h5PXn9hQ
	 dKP36K/7SF2xg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4430605CF;
	Tue, 13 Oct 2026 13:37:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B168D235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9753F4050E
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id berifkoWBIrl for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 13:37:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9CB79404DE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791898636;
 b=bq8x7UXi/acyeTU+8KUWMqKN6JMY6fwD/BV9jz3Rn9ZYuPx2QIPFzc+Ht+b/Jo/2fYK/
 z5Kz2iby1xMiqttrW2mCXixaSBRATPe0LIh55vlx+dOF5jrgH5lc8iyA5GgeVFqcaNjWy
 lRN1ASHatOm1/Mb710pKT9jyJYpiAhldVfEhzhEvVRPDQ6ye4M8fN+ChxXSsH7IeFgFzn
 mKS3BpOjDCm/VA5doMF3e98aMR4RRzQUJ9/cCbSxs6t7XL+JE1sPeyFBSO1u9gJIxvB33
 3VZkcU+0KerzFoDVKnwkWu0iXqfslRlyZE4UGWmjbEjBX3II/GtiLnygKNkZofElXjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791898636;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=hFdJd8GfAelk9wTmHIhz1RuNjSzBr/se8qjop3jJIzA=;
 b=UThZhV0AQ+LK6pCaGNwYEtZWz7K+Zdgv8+jVFKywTBjef9hGzNTu7Q8xJULISay40NeH
 pbHQTWwg0eZGNEI6eQUctR73HesJaJUkO8dtDLmzOrzU+hNjnHZ1IpnyLyN09fPUSxv9t
 BjKbcjM2UVyTUbrdMHaOsPKppL2gMt8TJlYVnyfyeQ/NhpOmJZvYqoc/rRpSCKO9OTLi4
 EcCG6HhlhNjAm59XirvBp6OpgFywuxEPwdKaDk08kIa9Di+jxTqu0nGhHC6i9kF5OQiLp
 JvEQ19E/xm+TtnzViLsDMvLUkuxuxjAMdRY7K4igQEMv4Hr87VY/zyY3Rz5rjPb4cVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SPfnMlGp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112d; helo=mail-yw1-x112d.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=SPfnMlGp
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CB79404DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:37:16 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-8ae9bc9a2fcso38890847b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791898635; cv=none;
 d=google.com; s=arc-20260327;
 b=lOFYDLSksLk8LL4aP3uUH0evoTz9+8WHswcqTiccSJgYQJHIa64jtOy3CRdvbjDSQX
 Dk8nYY1IPCYcRANfkbMdw0UslvE/ticgfGaWvha72x+Ska22oqkRWl1iXUfBEAErwfAD
 gmAXzPUMsFvww6iDbp9gjLZF/UqGZrn58M90YAeEoD3VTfgCFKII+bTyyFzQ7uIx43XE
 UuK0g+6kumNX85UD1+GLZ8N2goKMithLXhTOCdc7gifnUu7rOj2yHUSN1SdO5uZfokZs
 7aR9aFAL4DQ0JXNuwhHRNm6KyvqHObZ69DfTNXeHxBTQKREXXvQmuja9VZODDhdY3ScL
 4dNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hFdJd8GfAelk9wTmHIhz1RuNjSzBr/se8qjop3jJIzA=;
 fh=Buak+KDegN4xjh/MmJaROLYytZi5spLvMS58+bFNdYQ=;
 b=QXsUuQUunxb6efHuZ4K8yz+hMLAeOs9BP2CWk/3NvKO+I05vLMH/bL1rIaTBgMZSmD
 mdwr5FOhFt+J+sisM7iWpGan1+wnvMrJueM5lzLgaA8juXlZzH55ZR3g0kMuqmDRA53N
 5brgaiX7qEELGD1J8VADHqEsORPCSer5/ZBK4kwq+0u3/7/Z4GU8kGoHrZBaDxEJbO4Q
 TbWWvDk6AYBt/CpI3mppCEWt2Bli+A38CIwg1ZneBdAL7FwwdkPwOx/noiZQG3moBxQ4
 feQgd9UaFWhyUNi6Vs+u8VTF/VOeA7+qp8npax/jh1RRPIuqAg6FffEHcidBnX7V4hto
 tSUw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791898635; x=1792503435;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hFdJd8GfAelk9wTmHIhz1RuNjSzBr/se8qjop3jJIzA=;
 b=SPfnMlGpw6VCclJMG5AQGEmepV2lTjZk+lakuw6t07B6dr48APZyxQFFUy8rKL1jbq
 O43UIx6nOQmjVSx645Ho5eL34ekkdcRUF2lx7xYwEKUfmQiSI11uoVQapFxmsCQcSIvb
 2zHQ8VqceZbUR87taQfOozW8BVoriJeUTX3GAcW74/1wWkzWCNZFldxhHBtiuWFdzk+z
 ZVx5kO4jdwbUywKokapwjnEWKU8ZEPdmBKPCX3e2TUTHWTiKzMBYLw4P7w/mgAfnXi+7
 sxT+QJ/C2X4T7UFmahUk6OGClULwueNGCe6WOxFMBkP5ZM1m0PNoDNlQAhpg0S67HA/J
 5VYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791898635; x=1792503435;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hFdJd8GfAelk9wTmHIhz1RuNjSzBr/se8qjop3jJIzA=;
 b=Rv5YZg9Wq26bNJr7ikXUonjAD4uFYXfMd4upY2clIeBmdDUa0QOKP/rY/5f1wFBx+2
 clHTHMzd+knOambWH2uerGE/gf1wJ1vhBg2XMdc8C7q20zRPfxQWtZXV9fnIUXVei0sE
 ZBtdbVS1XhNCv3PNR+XiSu4yoW8Xxk/SOuJ20yjqGcx2wB1oBy0ouIKfKwVyktcprC62
 +3qCl3gi9uGNjLYmzdnP9pBycKsCk3LGlpyOpV98xPiiLF3rcUD0r9L5kqZMeigz7f1K
 1zdqHQRgfPvZGqhIqVsMD3BQzehu3/knymqsPlaneVuqQin/Jf3joH4qt7Y2b6Q8IIio
 mN2w==
X-Forwarded-Encrypted: i=1;
 AKwUvByIaiIAbpzUD30kP8cBXwYYKwn/L8M8qSkgzkWRpEkTJvkLNnoRRS0BL3G+cRKwepv33vTEFQU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJMJu4Nr9nC0e4gNdb2lDntLw49SJDupNc/Ym7w8RBSWu45VW9S
 8lV0QzQQVgg4aVAqjU3BIKZDCVsJfa6VvNTBZGVcLWLqKGV0rI7tiBJ3ccjawmwrG/kpmdVLy5p
 wf1bVTuf0A+t8wpP+Q1yedXac0x6gfWs=
X-Gm-Gg: AYBFou3Tua0uLv3XomuKkFbBcP7Q+RScBPDnst8Hab8+l7Kuulc8GA+kX8Saw6RoqJM
 8GXtuh3VXwmCCV3KGFyhNaFMdOdjvELztoZnOInbCsyJP4vsXT1zcUkkI62O/ZGNH3iCN2vIrxs
 NPnlepwpW4JBeqjKLBWUgitNg+BoF/xIHrICVYV2FM3RgNMD3xzOGAkYu/W13rVffYo2lEPyJdj
 AsI+UrIlQqpZyNT3UV4ndDkdW6NrFEjM7qS1wdX01qHI1mHu+gweNa/kcqIivjRYbAFyA9X3Edd
 DPJR/TnwF44ZS6tQHIXoMGwdzdljmn03vBn8BAedytxROs3676ElGLhQtkRZpB34Tc+elaT9skS
 mXusL1WKR6B2afb4=
X-Received: by 2002:a05:690c:6d8b:b0:873:5c7b:c13b with SMTP id
 00721157ae682-8b07d4b08d9mr41686677b3.35.1791898634958; Tue, 13 Oct 2026
 06:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20261013-upstream-mmc_sdhci_timeout_b4-v2-1-7c6383b789a5@oss.qualcomm.com>
In-Reply-To: <20261013-upstream-mmc_sdhci_timeout_b4-v2-1-7c6383b789a5@oss.qualcomm.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 13 Oct 2026 21:37:04 +0800
X-Gm-Features: AclHuK_ExhRcLeYHXtCZR9exuzJhKbI1KyMb6AvpLtoy_4H-9yNHw3GcXqxwHrc
Message-ID: <CAEUhbmXik10TFOJt4=j9D=7MO9toE1acB87YcXoJA1USUbRang@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: do not time out a command that has
 completed
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.u-boot-project.org, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
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

On Tue, Oct 13, 2026 at 8:15=E2=80=AFPM Igor Opaniuk
<igor.opaniuk@oss.qualcomm.com> wrote:
>
> sdhci_send_command() polls the interrupt status and gives up after
> SDHCI_READ_STATUS_TIMEOUT, but it evaluates the timeout before it looks a=
t
> the status it has just read. When a single status read takes longer than
> the timeout, the command is reported as timed out although the response
> and transfer-complete bits are already set, and the caller aborts an
> otherwise successful transfer.
>
> This happens on QEMU's SDHCI/eMMC model under TCG: a large ADMA transfer
> runs in a timer callback while holding the big QEMU lock, so U-Boot's nex=
t
> MMIO read blocks for seconds and the subsequent command appears to have
> timed out ("Timeout for status update: 00000003 00000001").
>
> Check for completion first and only then for the timeout. The check sits
> after the SDHCI_QUIRK_BROKEN_R1B handling so that, for a busy command
> without data on such a controller, the quirk keeps returning as soon as
> the DAT line is idle without reading the response, exactly as before.
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
> Changes in v2:
> - move the completion check below the SDHCI_QUIRK_BROKEN_R1B block so
>   that the quirk keeps returning as soon as DAT is idle, without reading
>   the response, for a busy command without data (Tanmay Kathpalia)
> - add Peng Fan's Reviewed-by from v1; only the position of the check
>   changed
> - Link to v1: https://patch.msgid.link/20261011-upstream-mmc_sdhci_timeou=
t_b4-v1-1-f33c02445924@oss.qualcomm.com
> ---
>  drivers/mmc/sdhci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>

Reviewed-by: Bin Meng <bin.meng@processmission.com>

FYI, an ADMA improvement patch was proposed on the QEMU side too.
https://lore.kernel.org/qemu-devel/20261003170232.2450916-10-bin.meng@proce=
ssmission.com/

Regards,
Bin
