Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909EECCF2C9
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 18:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3459060622;
	Sun, 18 Oct 2026 18:58:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ht21Wco05qs9; Sun, 18 Oct 2026 18:58:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 833676062C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792349913;
	b=M2OMbYcjpOO50ZPEgxAm3Xdb2A2rmDecsdZmMjfnD2EYXfNFOw8cUKugykUhjJN5jGN7
	 s3ePcmWabWSU75YtPyULH+TGIOGlokNrNvk2Tl61ovN0A5/YjH98sOjmHYz5CLOCmgrw7
	 k1VtYwBh5WBdc7WzDM8OwEKdWFQevSYISo6P75qlzZkL5iHwRwIotKmDsz7ll1GSf8Zpt
	 D9wghiAV5ml3RejF3IGjJoxKej4Ou5H2Nn3w5IbjUOa/swWxg4LJw5ninKgLfrdDJ9Ncx
	 QNzfqHfvPPW7ivDiUg4trQrHsQhnPaO32D37WYtGZvYaaY48Xfl9efsN8uLQfppxHMg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792349913;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QEqV6IuElUufBmAJTQXOnvaEx2gCg53wIOBHAyt8uUY=;
	b=jCtPeJG16fbZron8Qlyw1qXZ3tyAjpcwM77MqIbTHTLOG9jbxrQ0yelgyNUFwJPWCh1b
	 1PeHXf/PRJIzbmnobvp25R3bL16GjDwx+8UjpZjH/z1XVdxmRf7CKNv92kNrvqB6pwAS1
	 94+c7bAgZQdJMquRuPdV50irRdogUuuHLVaofAtPSWAgeAkLs/bgXw1n/FiA/Znfdv+bd
	 qHGlnH3HxVcl5PNmI2bnavQOuKk77ORQ6Gm1z448G3yg2MdtHG0/bFAitapzjwc14nRms
	 8ygzvOb4TDwRDXwRwBANSCFXP8Vs8szvLVgixB0nF/ERkleL3NRt/zMdW+vqDxFetqA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792349913;
	bh=QEqV6IuElUufBmAJTQXOnvaEx2gCg53wIOBHAyt8uUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LX/Ao00NTbqgo2Nc3NewLxO7EbN/pbW8t9chTsd/g59Z1a9OVshOGcKMMsu/x8iWv
	 qd/vVGRkx5duHshzlT5HWGOJTL9BWrkL7CYlG/QI0/Vl6XA7rMgOE7Y9OwixuYfj64
	 WU9tJ5jEbuRSX/89LVCTVt1Sd/MS/7c6DD5QjzV8pgRI7p69kA73x0h99g2/zQEW+M
	 8XdBC/zKhTKFRgkqbBMpJm4HrX30J2r5ah20j7HMMhheComnYY8NPOG9j7PpuA2RAB
	 ChwXxnblLeWgd7pP2zSCuPn4t3TpczdfrLIYeSzZU4bag6QtkY7AAfUtckOLCxyH8d
	 MQe2BMghRKYFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 833676062C;
	Sun, 18 Oct 2026 18:58:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2252979D
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 18:58:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0932140049
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 18:58:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKaqo4ON26JG for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 18:58:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BAD784008E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792349911;
 b=clO5tSz5TfMqOAMAjZAmvU0amPAooR2E5ltAtpSnNWXavsEGmaQPGPmjLFcZgiRpXT7r
 Wr68v5qzgMYQumn9iRFh4blsMXBeJQdZX5YPAYWX9Pt3PiWSvcwljUKWZu/9A6N3nNYrd
 7soc2OHw7hlGV9WQmxUMv6iLuXPADVl0QOty7J1zIw2/ErKmsi37namOA9kfuhsNy/F/O
 Txo7D8BiR6YtrVJ2xEETD+aNytaUp1I22xBGcsB4isGI+GIVW2ao6kfxxW0X0pZsvvYEO
 Kcfy7Bm7/M0FMFVHIfjBp1brilB4TucQ0SEwbgPsJIWtSov3EwYu7MszZBPRc5kzdUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792349911;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=QEqV6IuElUufBmAJTQXOnvaEx2gCg53wIOBHAyt8uUY=;
 b=UxvBlCi0HC9vUW3GIPQr0tjHqzpAdhEel4WaPDQrI45UpM7L89rruadDvg3ulqJ0st9I
 PPdQ03Lip9NcUOkl9Iam1pDTZseSvA+3Cf1A7G6M/1a/J42mVAIrlfP+WN7ysHDtffEXZ
 QsjewUbDqJLENmb/aUENckd2/x1ZqXOcr9IDykhArpFsKgGWGfmorq7+mS5IfcEldV10d
 WA4BTJXIjm1qFopOGAYxd6JTgW0tXjMLij3qT5YIYjq8E5m3d3O/wHkVGrciDQw2f82c/
 b56eCQFbWmNIHRuNkEoOI+Hh4XTZDq2ioPlM7Mh/D45LO1EFzkD6u0LUuTDvAOx321Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.tenstorrent.com;
 dkim=pass header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=Vlk0Vz9C; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12b; helo=mail-yx1-xb12b.google.com;
 envelope-from=asrinivasan@tenstorrent.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.tenstorrent.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com
 header.a=rsa-sha256 header.s=google header.b=Vlk0Vz9C
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BAD784008E
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 18:58:30 +0000 (UTC)
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-679aeeddc6bso1444984d50.2
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 11:58:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792349909; cv=none;
 d=google.com; s=arc-20260327;
 b=fhKY7Pqk3mC9ZoH6TwFjHiqD02VkQBVVfl0mCYmRtXoiMqhfq7RalaRUm7w+X9kDcA
 VLvXCYfpcjyJBWqpw+na+KpyX/ZCIxvCmOU7KWiq9OI2WAwnbS0X5T3NpVETsS6zg2uQ
 z3w9ub8EhnpBkk5aaWsRzraXnPCJlLg8jksOljZaqS+LTKKPGitJ8Q/2wiGk4s1p4Fyo
 LUYIv/F/f4PmUKjEXS3l7Bh4m8O0q5YfWSb3+65o7vImi/Um7/M3V51hEfMmD/WY9Ixm
 e8rSXBoOWn+c5VrXpl7vbYk7iEdXS7aUSfP3BM49fZM7buN2ysQxkQD1b19TKtdaGCJu
 D9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QEqV6IuElUufBmAJTQXOnvaEx2gCg53wIOBHAyt8uUY=;
 fh=wYOX0HLKHiKXnHjiThLKGp5c2jv5UqzB0fUKMYGYMss=;
 b=rmEDEIEY+cK8Ufksh+07TNdde/7EGBwWaaw3ZhABB719LtIkHg4/kf3/8oSsWtMVX8
 v1JvqJi+dTbs8BQSLF5zDC1w7iidLw5eZwVvxmQ2a400F68Gn/rjBkn3kbNtlaWP/R9r
 v3rV7N1P6yvic806GfLdWt4bL5M4XGeMvYJQ3rlgJ+/epwUbkLqDR4JFff7GdiQKs3pt
 schA3BG24x5FlPDdjsT8HELiPsjlBJESPstVmxK/jc0OMeesGduq88pA5tWG3pRDDtPL
 2k3cvZGJBJUW6p8ImjzPXQorbn9lbrch0WxmjpfDeGth5mMJskQT05DLMTq9E2F7jZBT
 cKwA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1792349909; x=1792954709;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QEqV6IuElUufBmAJTQXOnvaEx2gCg53wIOBHAyt8uUY=;
 b=Vlk0Vz9CQ47v2oAA6jcopzELXKniOSnypVHv0FNnydxl6XAkMxOgTJcPX8j4YI7f/f
 CyZY/oAERQX5+uMzZOvhAsmyKS56qHE8i1Gsm7IpEH11nO16i5RM5Dfc/6kbDiD4whyT
 mewtJKsTZ7UVmeGWHeE2drsUiSye1V3/7BxjxyY1JJyzKrUOZW5oFr9UF/xwZwOQkrxs
 lwgflrIlCcpvAzTn//HpXWFO+SU/qO5xHggqTjHiKczZ1q/Qnq4QXyeFZwXnASpk9tYf
 EYDVIo+Juqi39V8Sm0eheEA/bau757xKa/cAL5VmLlO1lCtfXWSlJkWCVvW+ux+si/Ir
 SUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792349909; x=1792954709;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QEqV6IuElUufBmAJTQXOnvaEx2gCg53wIOBHAyt8uUY=;
 b=XDwP3IN6jOS416pODRExdY/u7kFtKhyoS608jTrc9kenXXG+UCug+RC9CqYrrAYX+E
 NT377F95I0slhj09MT0Q/DIJdpUPvQ06xCtN9P7WPcCwjoICLBXlNqzTHHP/bHaje6+D
 HH59fOGyZ1l9karZ1rImUKqBmJiF1Fj7R83FEEUNA9Bf0Szp7SwnoiIqZNz7buvxOt2b
 9VASqh5gNmtioHoC31JywSkUwVZ22iCpGYblyyKLP5IZ7AukUlKoh39+hL1N1+4T8PxI
 +2GlYyv8BBctxgmE1pwRW9P7L6F7m45+2Yv01wYWOI/NBiyP/ajxUAJx5qt56w8DvWvx
 kemA==
X-Gm-Message-State: AFq9FYIMk7EpS+v5TDESSJHlXpzMsEmbkP80KMIQufA5k+mAgjrFXbjY
 pY/Kyhm3fp4haXwXeMJTTw+ydcttGSNex2tXLxnQAPtxViGq9D6/+QFHlBx2cd7xgsT+WHl9Mq5
 Cre2/S2RfUZK4iWKN/DrNszeRXUt32duyN/0juLA4Yg==
X-Gm-Gg: AYBFou3IbL4ymBlYQWv35Z9BD1hVXNXhC1FjgtF1jm/U6i76vzfoXLSPg4pnuaZlcWx
 TZLSUFD7jmwjdCUGV5xDiPCyE2wg3Vl8mcDNUuJrOFsHOxioNOtkjWlKgCP4FqfmGxWnhmKELKh
 Gouqadb3y5AwQoSVKE28+jvjSpCoOPZEAGQljWLERLp/49tgT9F+X6WJXmLPhNRq/Df9mkADpdf
 fwRkILqIzUjhGDNLUL2qRKFWXrPBvyYgRhSME4HSsBQMB03CH2lyeAZ3TudXSvFKI5bxxDGiRK9
 gX9Ua9+8q/O6FeD1xtfkIgn0MSEef0NI32YYBWYhDf/xMI/YUzCx/RRxWnWgmvzc0LLE0LxAoeL
 vy5qRZaJwWrSJYjpq6deLKbJIBHISZ4o718vaia9Za8lvSMaqOS32cLM=
X-Received: by 2002:a05:690e:b8e:b0:679:cc49:55e6 with SMTP id
 956f58d0204a3-679cc4963d4mr1089256d50.80.1792349909311; Sun, 18 Oct 2026
 11:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
 <CALeDE9MD-rqVaVdCRDq1ruPu4EzCiHvog2Qtu=50hVSBHtPyiA@mail.gmail.com>
In-Reply-To: <CALeDE9MD-rqVaVdCRDq1ruPu4EzCiHvog2Qtu=50hVSBHtPyiA@mail.gmail.com>
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Sun, 18 Oct 2026 13:58:17 -0500
X-Gm-Features: AclHuK-dFGgPSqr3pHPpjBDsPDyh67CQ2gAgWC8M9LWuoDYH8vD7SxgbQR6TNz4
Message-ID: <CAEev2e8XZ979VL+WPWbLDu5dKUOSQRTY4QxEsDyxW0Oxoq1b6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Misc Fixes for VGA BIOS Emulation
To: Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On Sun, Oct 18, 2026 at 11:12=E2=80=AFAM Peter Robinson <pbrobinson@gmail.c=
om> wrote:
>
> On Sun, 18 Oct 2026 at 05:24, Anirudh Srinivasan
> <asrinivasan@oss.tenstorrent.com> wrote:
> >
> > This series contains a bunch of mischallaneous fixes to the BIOSEMU
> > codebase to get display output working in u-boot using an Aspeed AST260=
0
> > PCIE VGA card on a RISC-V system that doesn't support I/O ports. This
> > was tested by passing the card through to a qemu riscv64 VM, but should
> > work on any board supporting PCIe in u-boot.
>
> Why are you using BIOS emulation for display output? Why not just use
> the EFI native frame buffer support?

I don't think u-boot supports running EFI option ROMs, and I think
that most GPUs don't ship with those for RISC-V anyway.

U-boot does have support for running legacy VBIOSes, and also supports
emulating these on non x86 architectures. This patch series is just a
bunch of fixes to that codebase that were needed to get it working in
my system.
