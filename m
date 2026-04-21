Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC0CF8FA6E
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 12:37:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34B383E76;
	Tue, 21 Apr 2026 14:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pIfwGCN5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E40484309; Tue, 21 Apr 2026 09:32:15 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75EC183E36
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 09:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6948579e5e9so953756eaf.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 00:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776756732; cv=none;
 d=google.com; s=arc-20240605;
 b=a2iDDbVRlmOsxui3NO4j94sf+N840z7qM+A2H7SbFNgmKarb2lHQSDPLXMLKSdxj4u
 l4RmTcsUnN0SBidTqaFs3cppCApi/NaoZbKeh0TS0uW8D8NC1U7Emk1xQMrf1Uw6fvQM
 Nvg/mOGOzSzuItNjdWhko2KQDJ61p0mgQfkeen3cwIEX7Sig9a7zyFnKm48SxjkmGBZv
 W2HO+n2BxhK/Oo/xYA1BbISOLonGLsXjhvWZVI0/Dpyf24uF3KtsEtNQ+yhkJ6FJQP0o
 RPeM7hE6AqP9UCPLfquG3wUHIUi3WW+TY/nes604ccMqbnPjVK5XaEDcesSaIJFjNuSx
 anuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ata8YAJIUezlzkr8HevnmAO34escW3eMoxQvYvBztoc=;
 fh=q8q6SoLD90WiZ7KnMGBG8IoDapUJmaCCtJlmDpWNZnA=;
 b=URzmUPrvtrr6j3FzujRiCc99b2UM0MO62/4WGRIQfDNq3pNcXWPIIRxR6OoE5xmcMO
 mZC0jeZ0MoTuc14+Q5NfufMoX342PR7FiZ+FjzGgXoLPLRuUlo5egd614Ly2PdnjD/tq
 mm9/5j0JcoNhbCHz/Jd4B5fcLOxkTm1R0jdp26imgCl2Rt3MJyunzG/Fvki9gU4IxdA2
 QhDuBcKFOjQdvHLyE5Qjg3zTP0h1Y1VNA1gzVFRUnEKjAdUkFu+cS/yUhirOXYbzLBLm
 PDSRC7q0Rr9lXfywPX93Xa9poboAwYwgTKFDzrBRExsYto/xzXmdoeWDzx47ygRg/GZV
 qDSQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776756732; x=1777361532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ata8YAJIUezlzkr8HevnmAO34escW3eMoxQvYvBztoc=;
 b=pIfwGCN5HHnyX/IO1cdKiafihDDrgWxJhclzIf9WFV+QHkiTv2O2OeMKj661Y2HpkO
 Yk2cgzi7jxPLqxFId55sn+NLVIt12TPcU69t4QGA8BxzwAOmxkNoH9auTCKaD9CON5h1
 rLH6/DGb6UlIhVS1NrN8jsuYolDr31To7GC3d8HTr3K8WfTUPLj/A/hsd0dee0vBSwcv
 MzS5XznV37Lm3W9Yb90AYuKLvMJxvB3YeP+WAblMjEpJq0eCw05HVSzJ2y0HRICKqUKI
 d3wyF1AJ5yDpJb5k0FPXhY2B3j8JG9SNBtZwC8zncnq4KY/NzZUIsf94KJheK5bVXwhS
 rvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776756732; x=1777361532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ata8YAJIUezlzkr8HevnmAO34escW3eMoxQvYvBztoc=;
 b=f6O+Q9g08f/Ap0OENN0wPf406mGFbwYSH8TOLLL+381xVblT+V9B6n6JvWSP6ok6/0
 kaIkwJJpVNq0Ik4XEaC8TDOoxhAxMZ8Oq2KX7a85yuR8bPa+pU5gPiKLsuuGfInw3w4A
 CSu5g5sWW0A3o0IToSxuqPR3EK6buSv/IeXmxFcLvQy03C91okCSd1Tx6/HAX1sB4xPS
 onGpquBbLtpvBZWV4gSyj0fuxjj5Q/fsxMB64DLKNgQBfYqMaAzX3x4Q8VouP5rCfV4j
 VSWe8o5gQ9X8giPtVXrWnaYOTsm2aB5TukWLbVEnxcxVDRhAU8ZwtoRHQNxZoyDdIx5z
 wR0g==
X-Gm-Message-State: AOJu0YysLou1xutcuEHWJSi6z+uzW6F4zZoSJQ59o1FY1BebqWvn9h2E
 aY41nfMX5BFuovC0xn+Su5kCyntDGHyDNA1AG7ouEpmojYUu8+soTDl9+CCKxmiJhRo3lRmMmXT
 swyZfezAQAbJ0OvsB0SHWV46IVAdRK9E=
X-Gm-Gg: AeBDiesi5l3fSg24ixb4x2j6S34n1YM7Fx3uvZW1xF+3uxPEC7tZzaFlHJByERhPeTv
 eymZvK5wu0OmN1ywNya2RuKsZoP3PZjW1GRltsRmU2omOlUEig/nPU/1YDUwJBuIdTFtufeCtWb
 yxqEHALAgSSHzQCslzuIywbACgg4V+aWs2SrQjeSyXiIpP82lBs43hK8hO5G65ivfZcpPe5qXPb
 UPd+2aNGHRu7yQyc2oBJlqnVOInVsnHsanuphmspV+Z+lxZ+lR6sOOI2ZGmXXhrw5snHwbtY4K2
 MDRPGV57RQeUebcoy9s=
X-Received: by 2002:a4a:e915:0:b0:694:9861:ec53 with SMTP id
 006d021491bc7-6949861f218mr782589eaf.5.1776756732126; Tue, 21 Apr 2026
 00:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260415172113.273702-1-micbis.openwrt@gmail.com>
 <aaa1648f-7aa0-4a76-b21f-3566bf40f528@mailbox.org>
 <CAP8xZ6mEb8A8epx+j_f=NS80hdOD7MvzzuUHDb3R70WgXioBjw@mail.gmail.com>
 <5aaaf387-f48b-4fe0-8461-7c3f05e27fe2@mailbox.org>
In-Reply-To: <5aaaf387-f48b-4fe0-8461-7c3f05e27fe2@mailbox.org>
From: Michele Bisogno <micbis.openwrt@gmail.com>
Date: Tue, 21 Apr 2026 09:32:00 +0200
X-Gm-Features: AQROBzDzu-qKb2bpuAcUpKRxiYiNbCFSjJx849CXj2DwUsBbhPq2RpHkn-wCFKc
Message-ID: <CAP8xZ6n3=ryYZF7hmx1-m-CHneAt9eyKwKy0qWRzLNCpF+mwRA@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: renesas: add support for RZ/G2L SoC
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, marek.vasut+renesas@mailbox.org, paul@pbarker.dev, 
 jh80.chung@samsung.com, peng.fan@nxp.com, lukma@denx.de, 
 mkorpershoek@kernel.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 21 Apr 2026 14:37:42 +0200
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

Hi Marek,

thank you for your comments and suggestions.

> If Linux also contains the PIO code, it would also benefit from matching
> improvement, right ?

Yes, though I have found the fix is not strictly required. We can maintain
synchronization between both repositories by utilizing the cfifo_byte_addr
parameter for the RZ/G2L and similar devices, allowing us to leave the
existing PIO code untouched.

> This should be a separate bugfix patch.

Agreed.

> Ideally, let's try to keep the Linux and U-Boot driver code base
> synchronized as much as possible.

Understood. I am currently preparing a revised patch set that aligns with
this approach to ensure consistency between the codebases.

Kind regards,
Michele
