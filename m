Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB5ACA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 05:43:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88CDC605E1;
	Thu,  8 Oct 2026 05:43:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAy8TgZ9kFOT; Thu,  8 Oct 2026 05:43:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DC1D060698
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791438212;
	b=ajE6vVF22OwDIwx0Dv7PtYlG/tIyc4mua8f1/Dc/DIVpUmtQ3ww5q4wS7UVf21KI804Q
	 uo5aL8S1LUFofOYIamL+IccUqHeot9WdPfmiq7yjT0Q7ySJIxP91BsAXs7oXbcBJR/8p3
	 OwCAU3IDySkivhX89HpZIGF2UmrXjDP/O9gCFG4HnfIr5vDLsKFnC0VBBgweJtpwnJED/
	 7xWWFBdbe10EKp6z6RilbyhutS+OnlreaLxGeB6LtrWkY66SFZvddLfLJOD5YRB/dWTIY
	 WLFa5EHAq+FJR8U9riQpoYZiU9YZkoflnbkHa0bdmC9yd4gbFpA7Sf/kgw3HkD/AE9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791438212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/qf6x9sulZEkCpB4vHQ9/efkmz4qhx0CjKQyLN7ddAg=;
	b=gc7qx7E5zfGEJt4/VBQjcV9yBzlMtWemDgm97hz4L47CnmoeMTgfMvPvTrlN/jQsnxBr
	 MxL3LQrylBT4RoaPz0H7rggtPFcuKtKeyEb0hV+58rFopwjJKsY7L0ffityO3TD/fvgHf
	 7uKLuQJ75DWJIugiR2+tc3EpLUbav5Wd1nBO5S4cdzik+HroVDUjZ/rMef53ZRzoDIMeG
	 oOyyCHHPoc5F3opIUpYP/SmaSXJSXQlHanER0i7BP97gz50nf7xhR8ibvOQqc9ltoMFxd
	 5GZNtphTXTDrwU1gg8/WZZwBpuVctR7+PyZBYied9V/TFfKfK6zB33I6SWy9y0QzctA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791438212;
	bh=/qf6x9sulZEkCpB4vHQ9/efkmz4qhx0CjKQyLN7ddAg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kj6pX/xUBn0veMo9d7Jn9PyQ8IqHmIhi6WEJXjOvfSDofAzC8JZfPB0nYsJruRkAS
	 G4HjDPLT6mX42p37Kz+P5ZD/TEsxPLPKB1pnn5uABMbmh7ajJJf3Vr4HCmd7IlEtHN
	 21cOtXyyRR5i+sHxf2i1E4hRLhUHNxvZG5YxSnRHkN1xkWZbZfdZtynhe05mdccleY
	 Tgg+PiC1yxLdxacMR7cy2oZTIvWI67jK6oG8Zdu7OBjjyyL/A3bt1HpTxFACVjIJQ+
	 LnR/YOey0ptu6TtUR2hUVOvOAbJqz1LH2hKTilw4Jm3bRt8P7hBZNjlviJIissWiy9
	 X3sYBhUWfmIGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC1D060698;
	Thu,  8 Oct 2026 05:43:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E2A421D2
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 05:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DFF0B8101C
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 05:43:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nXeOa52lew4d for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 05:43:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 170B481016
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1130"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791438209;
 b=CF106Y+UeQ8r3m1ZqF54Vpxw++oh2Jon9YBu0czANpbYH9jdA1PYReHbuZKunORQcC8I
 g9E0ZXuW/Zv1rMQsxfRe8e1lbAZS6qaUVRRuVlZuWRsYhiADisU2Ox4kwLOTSF1me7Z2n
 dQjs6lg5u86c7d3v3G80c4uFSbH4Y/HtyaLmrMQO4Foid1D4vbXQ8BSY5DLI/jaMvX5rr
 7TwGSttTUGRujsltuq5+hcc+/4UAHBSi8+Fs+27w9UHwGskqWJmATdcunuuW8htE35TP8
 N1Nm6owARoyXignu14mNnlQoQRFJcbnd3l3qbZ4BYkOXoMmSx7MrJZYyIrwnU1FgJuA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791438209;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=/qf6x9sulZEkCpB4vHQ9/efkmz4qhx0CjKQyLN7ddAg=;
 b=ATXBkcA6WoPQVftJzCgKHOILrJyogruA41XeRU7Fb9SvkGP6iMwzIcmJZyPlWTxf4k2E
 2AbYfD1n9YJ9izqKn3Bhuz6jSYSfE1ExnJ/YTAyrktVF3GIK4Mw2aQK+r+5RwTV4xg6uL
 zmcu5/2UrxS4/Zbdquisbi2w/2zAEZTnUbdbs4p2SvaGthipU/An+KwOqFtYyIag98hNU
 hBvyY5TdfYtTDr4oizzWktSZC4SJvDuF1EbzJSu/vK9vUQoSmRI3cz7+Hj+Ei7embh7TN
 XlZ5GHc9+9pao3XqsJd+HDUFcr2FHInTHsL5HHXCEyfVJt8m3znIzYTuA8YlEXBK/tw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qcycJ4zc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1130"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1130; helo=mail-yw1-x1130.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qcycJ4zc
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 170B481016
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 05:43:28 +0000 (UTC)
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ace0741488so47593187b3.3
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 22:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791438207; cv=none;
 d=google.com; s=arc-20260327;
 b=VbebYZesEKNMPDU3/Lm+JWWFE1hryYLfjIPZmfL7nWvabXBbOsm6o8Q5DwZivM2df0
 LVO0a7SLm/SbDEQsWcVk9uoox55siG1HxW5+MmltUBSPOWHwDio7y7/KVglek/jbY1Ah
 /V12X+goRP2pnjge3MI9UmcJ90iYIU1dBANVx713GVJc2hdCT22Aku/rZQmgR3WVAYm/
 CKw4jsauklzpx4BIjbTQxyIFcJyqqjuPAPadq6SnJtur85tnmeZBK8pWQGLJoYQ+yVvd
 UtF21npTu4U5lGT7SMwRNNUWqAQWyKN/PIegXdfMHQcvYUuR3kpSsQyItKQJeV81onDl
 SOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/qf6x9sulZEkCpB4vHQ9/efkmz4qhx0CjKQyLN7ddAg=;
 fh=6O1MjM2sBId90UTs9X7RQUpzHDT0UgRVSohlKC6N9zM=;
 b=UgjXG35YhmdXcqaX/tR98msTis8VUukE5hFkZwhiEaW/ytBFlRFY46MHQn9lmZ+dHW
 pWLGzHwO+IjqOMCH1ImscEFUhCkjkjvHPoIrMOjU5G4cApREJ1nB/t7kUHMS6ZSO8TE/
 cpqYfVoHfvizM/ignDvB3VYZ/t1Izd9ZiOGWHeim3WvQf5Ml55Ii5Nm3V4i0CgPrFwQP
 U0htMDv4q2+tIJ7Dgud3JgnJTnFldfTSZzTNyX4w/F8wF1V7o3iFGC426vfRsEBLkVST
 HGTfooWA0v2ha1R/624pQLpPnieV+HIYgrz3/mtnhE4WjCCycgiFjyDQzr5OuNSdyIPd
 12Jg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791438207; x=1792043007;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/qf6x9sulZEkCpB4vHQ9/efkmz4qhx0CjKQyLN7ddAg=;
 b=qcycJ4zcBx9t3DxTjK29vUIc4emZuQp4VaLnZaeRbY0hX4LaPnRtisR9BdUHvBqQ32
 0RzVEKLnT4nwJ2piLw+GrqBb7whg3wARyl6X3l2xUbX2nMBMi/jIt/9PZyTZhs+wAi2b
 IyZAZcWSxJEHInz3+yX9Z08kdHYnGg8kWO6UZ5M3JVjxA3anN/WHpQbpIYwgJAhXotyb
 Tk5J0Ims4TLGL3HuYVtdh2/v76XvyBCB5w7a6Wr9kqhUImH4xmagCa4w/Tm+WIdQ1Rtr
 jNhKmkp/h70K1XKm2GWz5KG+joVPPtcybBY3HGkl59FesIHEQSf4D0QdzWzChiAB7lYM
 5i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791438207; x=1792043007;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/qf6x9sulZEkCpB4vHQ9/efkmz4qhx0CjKQyLN7ddAg=;
 b=1SfFVSOeOF6hLONJciq3x/k6jliSJGVDDudKe8bsWl94UI/lUSzkoOdc6bPUtiTVYx
 W0clmSgGUbYwpF+Y8hZhycCzv/XWt9bTnVmY5PVnWDe8XhCxNMcxIm/PEPqWeiDmmisS
 Fq9oKo6ToyYOIhgLr857VFYUqe94xieQn77Vk4PqdavU3XPgAFlwJEQzJp9loT4UO4OC
 sNs5JSalzKHwZl4O7yNqD7gVlvjVd58/80cUiRiplW7tWRaalCNDL5z6MYt55gZtWZS+
 Erd8wL3KowH0Ojifvi0qbCyQK6Qpd5XoILiNUwXevfJI196mVK2qTtLWgfTMj7iftn1X
 oEcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhI2xNgFXBpNq7uDoDsQr3S6gHB/kB+KeYfaxatSwa7nGQtXYIcY/yYV77bWecyebM/SkbXmQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJj3EBHRxWGGRBZFGiWRWzwXqioPLvvQEYsM+pGxnYbAa6U7Pkq
 i0QGSx+ea7HmKDmxjxAiTSN4Nt7XOx6Hm869fWSHzvK/ARv86c1J9r2TfyXmc+YL8fOBphDlt9l
 7fY5q+Gp+/VFRLlI+LdtGQ07whs+vGbk=
X-Gm-Gg: AYBFou2xCCfhIslINaOnkm/LXazsb2pgj/Ezw902fHZ4oEzkiSwvpULFSUGODw6tmOc
 NRBpmdSygTlg3uxYMt/PwPPMXNVe0AWdQoZGFxz99WMcuDRYhCjUWTb1mguhDxs3VF06BWBgjx6
 JX6TjtO4oRW7zhdPPgzP8uR+E+lnVJtlt8LBI3Xnndc+XAg7q5Ted0bYFFvtlMRJSIj3eX9BF8W
 p73aFZKCJF2BJqlfUVApi3DLyObutUb2LKLn9WzuEmrQwVZSUypgwb7N3V+Qza1pVTVgSye8b1O
 170cIhMtGVUtFJngivhJtNjNkmaOQMPwmxzUERgrplbfuV4XVYAE9LueybHENj0VPKScT9NS5Ko
 qxDd2YE/2cdZFFZlT
X-Received: by 2002:a05:690c:5883:b0:89a:3ea0:349f with SMTP id
 00721157ae682-8b05aece5cbmr20237157b3.51.1791438207489; Wed, 07 Oct 2026
 22:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261007190905.29585-1-heinrich.schuchardt@canonical.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 8 Oct 2026 13:43:16 +0800
X-Gm-Features: AclHuK_IisI_g1bFj5hA4qCrLi3SdapkGFIEggLV_as-RcAuTH88brCN3RDSKBw
Message-ID: <CAEUhbmXm6UW+SGEyadyeH09m70X2xVsLSPe_6iTTUmptjKKt0g@mail.gmail.com>
Subject: Re: [PATCH 0/3] sysreset: provide sysreset driver for qemu-x86(_64)
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Johan Jonker <jbx6244@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alexey Charkov <alchark@flipper.net>,
 u-boot@lists.u-boot-project.org
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

Hi Heinrich,

On Thu, Oct 8, 2026 at 3:09=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Currently we only support reset but not poweroff on x86 QEMU.

Could we just add the poweroff functionality to the existing sysreset drive=
r?

The new driver is missing EFI efi_reset_system() implementation,
causing EFI reboot failure.

>
> * Provide a new sysreset driver for qemu-x86 and qemu-x86_64.
> * Add nodes for it to the qemu-x86_i440fx and qemu-x86_q35 device-trees.
> * Use the driver by default.
>
> Heinrich Schuchardt (3):
>   sysreset: provide sysreset driver for qemu-x86(_64)
>   x86: add qemu power controller to device-trees
>   x86: use x86 QEMU sysreset driver by default
>
>  arch/Kconfig                         |   2 +-
>  arch/x86/dts/qemu-x86_i440fx.dts     |   3 +
>  arch/x86/dts/qemu-x86_q35.dts        |   4 +
>  board/emulation/qemu-x86/Kconfig     |   3 +
>  drivers/sysreset/Kconfig             |   8 ++
>  drivers/sysreset/Makefile            |   1 +
>  drivers/sysreset/sysreset_qemu_x86.c | 155 +++++++++++++++++++++++++++
>  7 files changed, 175 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/sysreset/sysreset_qemu_x86.c
>

Regards,
Bin
