Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199A8CCF2C4
	for <u-boot@archiver.kernel.org>; Sun, 18 Oct 2026 16:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1A83406A2;
	Sun, 18 Oct 2026 16:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F9N-hZ5qt7eq; Sun, 18 Oct 2026 16:12:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C8ECF406C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792339976;
	b=Vc2zIRYsCW9hmxskiSamrOWc/fGo15r8ffUqr/hFeHLEAYyPif1Rkouv978ucgCjM0i/
	 r7UzZQPPyHrMkVliJsbcHt/qRyS6XZDkP5Esynb+TGxdjskixV2l0+AJHGSElBSJO1o54
	 j1xB/ueFDt2Lw2T/SfQnS84LAmLpPrK9opzvS8m9yytiGvFqHwgE+pAXXeVPF3oIR1zOv
	 lf93ue4287k+5hAPKoVQyqg1EhIXMu0f4WBwIEwYRff+lvri3hBGZnp8Vu32pmqLDcJzW
	 fPAECn1Y/pP9avMI1+8lby8D/4+o9kiMzen0TnBOVA8FkN1cvNL+/LxeTLgwyUHma1w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792339976;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GBJCwIN2dQkcB1j0lYLn479B8kbmu6hgBIHEeJqp/i4=;
	b=nkwA16wGRtpSWpj8Gy/wkXogoGKsRsX+bOe5kcCkaMWCtWFQ1tH/ve62zhptbMjfU31+
	 ngwasdz/4GBTwA78HDfdG3/ih+t00qgWUF7i8J3pYOXiP2qg2NP7+4ZMdw/kg1c4BOTG2
	 AWvHoOF5hzifemQbumlTCevZQnNqizMESAhuP1GzjawLnJC7qv1HtFAe5V3r25a25qyG/
	 sro8xBAgtQ4dzmu9Etqrm/bGMsZu2LAKvjZT+7ZfeFlFL7Qc7anLDPbojGkAtYGS6CNI0
	 pOrORon8j+HD9NtFL1spaS87kSlYUQdb33WaHqYVsPZKO9XnwC/xqf7vyFhuH+xvnPg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792339976;
	bh=GBJCwIN2dQkcB1j0lYLn479B8kbmu6hgBIHEeJqp/i4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NnOkl82+aBWtPoUDG2Z86lpOHiDYHng+IqirYCZ+S7ZzbqDrklV6bXusLg455/YA7
	 eKZ/0aHEi/B9MvfafOmuy7ChABRsLD4dKFW1cOYugWR9I+tzWg898kYM7vhx9Us2uf
	 y3+Sw75JJTAzBP3JCmQ9fCbNNkxdlqY/YX0Htiqn9eH5u/PcnDezlODXg9ErOh87rn
	 veu7jS9v4pMAAf2Gv1ZGFjG4ydQdNXiIbMJo+doM64Yxn0DTTnCVUXHcHX6EhhWFma
	 L7Gk4a727z5RdVKuItSP/WtMH7zc4ge/4FQ/3nrg6WoYmDykirPzcOT8dWVbkWZURa
	 WHcVFIt+P4JWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8ECF406C7;
	Sun, 18 Oct 2026 16:12:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B2F5F2A8
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 16:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A4F3C80F76
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 16:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8zRkht1pyxQc for <u-boot@lists.u-boot-project.org>;
 Sun, 18 Oct 2026 16:12:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A18FB80F6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::f34"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792339974;
 b=SpgW533a1Nmaf0v2UCbUe6wsFJ6GE28j6fzpK1FP4K2ss3DC9Qp6XfLp2VsSMW3ruorA
 H8hcbgNj9E8B/MIdJXmms4/kPoXz2BKTM9ZcBghBJ8n2ImuzIUM0vrk2nrewHtx+AjomG
 lThb+Hi2Nblm/+LJfcukf5x4TmWi1BMXJQXXvJX2YOmAueU/ve4w6JOgZcGI15q037Vz+
 wojminZc5jo5/wo1MdjyPDyKy7Iv0uglwOj/y6IsSsAl5fQLV+SPR690PPS+7de4tQzta
 EPpYuIi93rbcIzIHTPQpDnQzxIJaup4NZuHwjl3oZnA+0B7qN3d2anz81DltSnWS3bA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792339974;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=GBJCwIN2dQkcB1j0lYLn479B8kbmu6hgBIHEeJqp/i4=;
 b=CRBscWdC3HSQ89K1Ia6Fhvx3OVAXf3yuYRZ1jIUIKRA+zOQb7kOsTFl/kKHWJaqJWeVT
 WqzEGKWTdwh7LMrKRxZiY+d00Q4EUZZdtHzHgIBE0ctDpoTBdMoEj5vq1PAT81zBGXMWZ
 j34Umqcb5NjwyqM1UXtuWpqMy2m3hqGJ/3zEINQqD6xF92etPcgJqVNUQJ2uNF83MGGYN
 TywIUKAct6Hmo3SroKM4Mb1+XjuMoUOJeW8LmSxQKPbGYaLAJcjN9US1gjo8g2ukO2VSj
 8HZmLp8rlnVapoIkW+1uAYmSiesu2CsjD7lK94Zq0mh5n6xa+6k7YSRM202SrPEXL4A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="DTvTDW/e"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::f34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DTvTDW/e
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A18FB80F6E
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 16:12:53 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-91bb5795792so11328966d6.2
 for <u-boot@lists.u-boot-project.org>; Sun, 18 Oct 2026 09:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792339973; cv=none;
 d=google.com; s=arc-20260327;
 b=XBPilfQgSvmINUCdFFfZWym4X/Fd/N0lRQw171K+EHvOXUQGVIo7WfagGJgRuAQuC2
 q/w0YKqvYAckUtun69YqOCJPc93luqqjn3w2nH/u021EgaJ9pdNGzAizmzm7b+a63KCD
 ZSewYhpdgN0x9u//+/ZThTAK55PGXrLNMY/L07Vpsve94u7ZzUOtFegOQ9v3SFZpHuTG
 68Bg5RLPzBC7WAq/39hGgh5erl9fjcrAMOQp2iAxn4wBNN5yXFNBSvvK+LewFEjd2FH3
 +I9au+MaxK3l2s4I3yzA7/eU9Z8zPSGU1TgLX9TarNSrsmgKv4fjqWB7iM5NzSQquM6I
 PcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GBJCwIN2dQkcB1j0lYLn479B8kbmu6hgBIHEeJqp/i4=;
 fh=FLUS6H3iBvkNhdBVR/4QOyYEso75lGCwcAZhF5/asUg=;
 b=JORFZ64KDOU/OzVPzWIBh6j748hHK+LanzSgObIS9nZDoQ0Nq4eyOt/DTxjnNJ63I2
 EqMsz1QQk44MmTJKp64mWWfISVB7KoP0tXg9kcjl0NNKfUGOoQ99yBw4dp0DuxiOS3xB
 hbQcMUkh6LvL0nXDHpJIvTVywBiOadRYgI2MIAFl5L0zwqqsnFNlWItCjZuivkoXiE3x
 HoUnfdw8GERrf2/h+4OEwYLURBacKMM+Q8vGb9HRNC8hZHEQmSYsRCsvxs9gQiKV6w4v
 r8aPV+0mGAlzBQWKvRBlpH/0zskMEQD3lJyikAp4voPP20h9gx8pc4eHEB9kxTxfho0a
 Kvtw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792339973; x=1792944773;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GBJCwIN2dQkcB1j0lYLn479B8kbmu6hgBIHEeJqp/i4=;
 b=DTvTDW/exUlvCExUCqVP1IyCj6oNgmKgNizk5ikC7jdX70+D40fGISPLjYrHn5ymiz
 ymsnseHddWx+nTfBeeWP3fuXx3Y5ZDk+PagxdUZN3QaQs6H8tI+93vJPEc8M4Y3N+upQ
 40l0yEspfeAxEeage9Vf1MIl/QSvD30dB8SmnffnQoyR6NaviBasMhQPSJ3QxDMkVDaf
 vM8k20E90KXXOEPNs/4FJTYpo4AbU2iLDadgPua0E56csav42NmX2oKDn8nCmOywxr6s
 8I5Awth38rHp5XmNeUEICAcVQeRNuJ/lMoOOf/hqdHetLDFIwKmsd8JOt8ZhQzTDlqF9
 MdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792339973; x=1792944773;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GBJCwIN2dQkcB1j0lYLn479B8kbmu6hgBIHEeJqp/i4=;
 b=w2YKF4UJhcSUjkAXUdoR/T4I2NS5NPbkTKFk6EquLJPg4t3a4rLEzX6+G7oh/IWwVQ
 y0Um795g2+SG+jj1/vvSHS7VdIYZx5F2tQ0ZWTNSMXgOTvTkkkDhXKxemVa3LKDKp8Xn
 sUfpTx1RI6ZQq9NoKq2SAaUlOpENPlEPlK+GJ6FHgWFUK+MeedsQrTnYNptPN4iTFkA2
 jc1+tO+LjUhqPwSzt9x7HzWpIEd306XrgRiOnYY/9qH+7Z1y0OfS1NbLj7uJYDvRT5gN
 URFfmgoFTDW5sxTcYJlCR2czArOpfISW9VO/+Esdb5H/nQ61HVrSv3mXy5qzRbJMdTTL
 5HAA==
X-Gm-Message-State: AFq9FYK5s6lZkxUq3v3Jltmq2v4ldX0WmrBziFKoUsjFganruMFtpdij
 /bw2ZebKx9O3+XDBAymiBF0M3+WlvofQOwkDbwXgay04HwC2YiPREbgobz3uIGWiBGhSq7h9K87
 ib3ApgUsTQfeFywkhNEvKhsbUU7CsVXs=
X-Gm-Gg: AYBFou272jzUNMS/1Xl//jnShf1VStxvcrP5PU940il5CxpPEkocx2l5PF7I0uf+Fc9
 0poFYtIkTnhDT1N/mpCGKclzGNzVPZ7uB5UGtXsYBKPVZdLyB9ZhREum9JojRZnRsjhaV90Ir/1
 xPefhoorMieJyVA3y5MsP71YcFsZj/pcOYVbVlO2m+oSEF2aQuSrXrvKrwOt79H2i55+qVRoEP2
 zQE05a/gQMZmqH2f29DDltSaQSRmucFkhsGhdZhnSMQ/3/fY+6ngml9GF6mLIAW0DI1dzM74v1a
 vkdOWgzQq3BTuoCXEnF3gc5q51Ec7vW9UtImTh5jqoCZE2RTyrhsosnST+rYhvgD6I3ARelBeB3
 hFe2P9w4tewLf0OIUOtLXTLThBm0XYpO2RKAW7FlNyIayX15IaKAnmpoN1AdiudRSuovdCx95CV
 W4/+LIpzuzcnIqRyjK8po2Po3L2j2OjIWxg1eIMYWzEsG8X5AR2A==
X-Received: by 2002:a05:6214:d87:b0:91b:a948:fbab with SMTP id
 6a1803df08f44-91bdec2ea1cmr101621346d6.6.1792339972743; Sun, 18 Oct 2026
 09:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
In-Reply-To: <20261017-aspeed_vbios_fixes-v3-0-961124989594@oss.tenstorrent.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 18 Oct 2026 17:12:40 +0100
X-Gm-Features: AclHuK9bfu5CsOelEdq-w0g69tmH8kg5t3nbGcyRQh4IxrB_sXDgpIu5dwG08A8
Message-ID: <CALeDE9MD-rqVaVdCRDq1ruPu4EzCiHvog2Qtu=50hVSBHtPyiA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Misc Fixes for VGA BIOS Emulation
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 18 Oct 2026 at 05:24, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
>
> This series contains a bunch of mischallaneous fixes to the BIOSEMU
> codebase to get display output working in u-boot using an Aspeed AST2600
> PCIE VGA card on a RISC-V system that doesn't support I/O ports. This
> was tested by passing the card through to a qemu riscv64 VM, but should
> work on any board supporting PCIe in u-boot.

Why are you using BIOS emulation for display output? Why not just use
the EFI native frame buffer support?

> v2 of this series only contains the first 5 patches from v1, which are
> misc fixes to drivers/bios_emulator. Based on the feedback from v1, the
> last 3 patches implementing a aspeed_video driver/overriding the biosemu
> functionality in a hacky manner have been dropped. This will be
> implemented in a manner where the video driver can provide custom ops
> that override biosemu's read/write calls, and will be sent in the future.
>
> There some checkpatch warnings, but these are from existing pieces of
> code that I've copied/refer to, so I haven't tried fixing/changing them.
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
> ---
> Changes in v3:
> - Cleaned up code/comments around freeing memory for allocated BIOS Image
> - Added a vga_port_active() helper to besys.c to allow the handling of monochrome/color VGA ports in a shared code path
> - Reads to 0x3DA status bits are updated to use this helper, so it doesn't decode in monochrome mode any more
> - Link to v2: https://patch.msgid.link/20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com
>
> Changes in v2:
> - Dropped patches 6-8. Those will be implemented using custom ops for reads/writes that the driver can override (like Simon suggested) and be sent at a later date
> - Cleaned up typos based on Simon's feedback
> - Changed BE_inw to use 2 BE_inb calls instead of VGA_inb
> - Link to v1: https://patch.msgid.link/20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com
>
> ---
> Anirudh Srinivasan (5):
>       bios_emulator: select X86EMU_RAW_IO only on x86
>       bios_emulator: Don't free a caller's BIOS image
>       bios_emulator: use driver-model functions for PCI config acceses
>       bios_emulator: support 16-bit reads on VGA port
>       bios_emulator: extend VGA I/O ports to include ports 0x3B4-0x3DA
>
>  drivers/bios_emulator/Kconfig   |  4 +--
>  drivers/bios_emulator/atibios.c |  3 +-
>  drivers/bios_emulator/besys.c   | 68 ++++++++++++++++++++++++++++++-----------
>  3 files changed, 54 insertions(+), 21 deletions(-)
> ---
> base-commit: a6ab6a66146ed0bf1420db0ee858b49005783222
> change-id: 20260718-aspeed_vbios_fixes-d4890ce2587c
>
> Best regards,
> --
> Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
