Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF79CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 12:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7500940D8A;
	Thu,  1 Oct 2026 12:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ei-iqY8fDGb7; Thu,  1 Oct 2026 12:50:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1D3B940D84
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790859037;
	b=aia28R6BF8rD2V+GYixad5GGgWxLGNnXQIt5TpNx7LeQMRGmxbaw9J+l6G4jZdbSxCtg
	 JWOENrlaXPDbRhEUwvn/ArS7DTMycuWQ3Pk7tEJ0i7w/FAMkrVAjvK33cp4aWvm3CwEbU
	 ps81SL/VOTkjChOVPix1TVjSE8c58FtiRnOL5fOOxd9MJlx8Q6aIpGl9uBa9uk6x3kHXF
	 m6srzl7YWWdFjv2OnRGPqkAn/nNn+wTlaRGAfv8OcgGcWMZ7iWskOCqVVrhI1ppxuMj1U
	 qudqDpFsucPXUk99Iqcidi/zhbYeTXACK/jWwLD0TPJbH6kTzskKVrvWCo72ogxVFrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790859037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:Feedback-ID:
	 X-Pm-Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NXHAfjegoVma6Jf7hVWt3lCm+VSvtwWJ53mqyQOEu5w=;
	b=MimhHA3trf1dfIvuHl5qY1obIUpnxqyqrk0jfHyn6c9oFxo/kb2149CROAcVFYhFdaxn
	 wedWmf4FLy76v/oAq+uf11YlAXr70F6u6JhR664XqsFYFm+Lauj2qDmC7GzaWaSBbMaSC
	 s78BInK+RiDelYzcZ99KCusfNlyYY1PdA6ibUweGhkCJmBcWBm+P+JB7gnxvCYJsR1un6
	 YYiPMwOZSIrwxzGGcPXD9sLpRGbbUJIZE4TtyULR+KWVUvrHs24iEA+8SZxnUKBOcKCYk
	 hPKt4sP6KmmBbTqCeTqvt3mUw4l+BxCKdgwxb06TIH1xIGGyIGdeqNjPFBC47uydoiA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=iWRXlev2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790859037;
	bh=NXHAfjegoVma6Jf7hVWt3lCm+VSvtwWJ53mqyQOEu5w=;
	h=Date:To:From:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hWLmILjJ1lI+9s6wx0AsHnCGcM/NC+Ry/m8pywrK26DBntgfqxP1yyITLZdwO+kix
	 +mrUaez6sp/0jDLy7tdaFQkwC2bLuxGYwEEyIpa27h5rXrFRxrBSTgmChgTICa49Zu
	 k106mhDIDa61GfE4zX7K38OS1f5MIyE0OyeoFnMUmXzjQ5wOLVib0jrAFp6KStdHX7
	 eR8NYgreGtYU+iDbIKCTIgmU7JcjRPTklid75HblUaME7gBSrDykcGUFpJ2oGxK+yI
	 h1MeX7bu7tzubMahP2GyZ4keMLoMQ4kGyXiAPso9VBHIGAjanNvsfmoRHQJBwqbA+S
	 tTkYa80OR2w9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D3B940D84;
	Thu,  1 Oct 2026 12:50:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3FD5333B
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 06:15:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 258BD40CE0
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 06:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AOLBJ_ITnUzh for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 06:15:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D979040CDF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=85.9.210.45
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790835307;
 b=f6Lek0Ow5r1RtL+2lZtY08Py1Ug91gS5kLcZWGT04eThaT80wQmECC1v4I0nYYjbnlua
 uXCqkeEnXi7JgeYN5VItUT9RqxJuHbGPqS/cxzu53lr4pbokT7WfWrpDlphnTK44PCn9F
 MTDprHW/Or4wkpFcaT4YptbUnLKv82WbEknDLsxgcVm4xsH55swZDjMMu9jGmny36kACH
 B5744gWlS3dXxqoXC1ZACAMwOHf6+8PbChsGjOVxfKeByJQSA4TOTxsTGWdyglmiWHxVE
 WVkEIzHZq+VMCr2N40ua4bqwDvCgrg2GjQXi6fxdsyN/csS7PvVyqkrCLFtKwhg3NKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790835307;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=NXHAfjegoVma6Jf7hVWt3lCm+VSvtwWJ53mqyQOEu5w=;
 b=tOt05WAZTrzuMh0oXaii0KyEmDJBq9IMEatidfUeoNx3s9z7GTJG3uDOOXPc377fWNqs
 4uvB3fjc3giIte/MEqUaRf2EjsKzfP5wtwkSYzjXTG3lGHsVAQVSSXEXheqBThjDxqNBn
 iaIe/PchXBrDx9Ur0fSXfcePm+f4lOBIMQy9sEu/fU+MzdpnXG5ElkJe8yWDQbO6k0kVT
 p4LajXkgctpmlzE0Jga4FcKQykXz4J/dEN/OFY2JKmRa27VsT3hG5w83hFu0ccBgVxr7B
 slSil5/h2Xogz/hGDWlsjibzZ/x7TzrCp2qZbQiIxCVfaGJD2ALWsksJFS7ugc9xZcw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=proton.me; 
 dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=iWRXlev2; 
 arc=none smtp.remote-ip=85.9.210.45
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=85.9.210.45;
 helo=mail-06.mail-europe.com; envelope-from=hystericaldragons@proton.me;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=proton.me
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256
 header.s=protonmail2 header.b=iWRXlev2
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D979040CDF
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 06:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail2; t=1790835293; x=1791094493;
 bh=NXHAfjegoVma6Jf7hVWt3lCm+VSvtwWJ53mqyQOEu5w=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=iWRXlev2BHH0kaUSG8BNc3QDlPHZt6WEAnmt3KplNQhzKU/sm3W4cnVcRvaPjZWbP
 A4hEVUjlUI0MBfw9BkuKGV2Xm2ix1s8OHWJ7JwDIe2xzPj0naxnxQcX/MkExxlBbNF
 1rw5E0QveNpEKId2SL1STzKgdEwHgHP5DTe9SvqSvlJQ9X3hZKp6nM04VbGNDqgU4A
 8GA/D9HpnwLNb6E/lMSTM0hgtqImV+LP2PrC8Yw+P+szJiUnSq7q07YR4XF7oTOGSB
 iRzCzXDlrqMQK+1FPaOw6Zv2NowItGr6PJmnrfGbKVKUesQAULfFsd52imvoJBO+7j
 D+/qdg+Og7FDA==
Date: Thu, 01 Oct 2026 06:14:51 +0000
To: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
From: =?utf-8?B?5a6J5a65?= <HystericalDragons@proton.me>
Cc: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>,
 Simon Glass <sjg@chromium.org>
Subject: [RFC] rockchip: rk3528: NanoPi R28S support before dts/upstream sync
Message-ID: <OjXy0xMi4UhaNlSDbglwvkf_FXX3Kg2TzBsaucWmd7YnY4tVJXGpdp-sUp-mApm8Zh9935uuKq1jhneCiItNCisIRiN66zEG8zl1jiGBFMI=@proton.me>
Feedback-ID: 91982645:user:proton
X-Pm-Message-ID: c592d1c2fa9a5791f11927c06f2f7129af379163
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 01 Oct 2026 12:50:33 +0000
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

Hi here,

I would like to add U-Boot support for the FriendlyElec NanoPi R28S (https:=
//wiki.friendlyelec.com/wiki/index.php/NanoPi_R28S), a
dual gigabit Ethernet router board based on the Rockchip RK3528, and
would like to ask how to handle its devicetree dependency before I send
the patches.

The Linux devicetree for the board has been applied to the Rockchip
tree for v7.4, together with a patch that splits the parts shared with
the NanoPi Zero2 into a common rk3528-nanopi.dtsi:

  fdb087806e80 ("arm64: dts: rockchip: Split out the common NanoPi RK3528 p=
arts")
  c1e23f3425c4 ("arm64: dts: rockchip: Add devicetree for the FriendlyElec =
NanoPi R28S")

  https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/=
log/?h=3Dv7.4-armsoc/dts64

Neither commit is in dts/upstream yet, and they will not be in a Linux
release until v7.4-rc1.

I have a two patch series ready on top of master (c92d8c3c431e37a17c3b37918=
037dbd7ade32d1e):

  1. rockchip: rk3528: Split out common NanoPi u-boot.dtsi

     Moves the vdd_arm/vdd_logic regulator-init-microvolt overrides of
     the NanoPi Zero2 into a common rk3528-nanopi-u-boot.dtsi, following
     the split in Linux. No functional change, no dependency.

  2. board: rockchip: Add FriendlyElec NanoPi R28S

     Adds rk3528-nanopi-r28s-u-boot.dtsi (only includes the common
     file), nanopi-r28s-rk3528_defconfig (the Zero2 defconfig plus
     CONFIG_BUTTON_GPIO for the reset button) and a line in
     doc/board/rockchip/rockchip.rst. It needs the R28S devicetree in
     dts/upstream to build.

I build-tested both nanopi-r28s-rk3528 and nanopi-zero2-rk3528 with
the devicetree files from v7.4-armsoc/dts64 copied into dts/upstream.

My questions:

  - Would you take patch 2 now, or should I wait until dts/upstream is
    synced to a release that contains the commits above and send it
    then?

  - Alternatively, is it acceptable to pick the two devicetree commits
    into dts/upstream early, once they are in a Linux tag that
    devicetree-rebasing follows (v7.4-rc1)?

  - Can patch 1 be sent and merged on its own in the meantime?

And, unfortunately, proton mail does not provide SMTP for free user. So I c=
an't send the patch myself.

Thanks,
Rong An.
