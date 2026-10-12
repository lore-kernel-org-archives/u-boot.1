Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE73CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 16:08:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 107384056C;
	Mon, 12 Oct 2026 16:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQPeRM-SD2jd; Mon, 12 Oct 2026 16:08:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BA3F340556
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791821285;
	b=MXgt4AOTDVyOCwiGTfaOsD0vSq+vYiGVzFihwkh3zprgVNKEeZN6q6ekKb9MEgP0xQC6
	 2DXKEZm87p4xLuYqZ6jAARquakQ0NNAg2XYz+cmujWh14CbbBzaBtn0GMvoGlVt47klKl
	 RYtmM9etlGo5a7zbfK+R6RU310DvD2MYJOLl0+zg6G2Wwoi7OCMiq3kkk46/uJ6pYGmZI
	 t4UAsrzC2JyYWJ9o+EGQMrwgwc8QBoXxxaG4VvYX5+IcYlbxB3WZoDVJ8ji8K7ZarZgyq
	 VD1luujLnVc5usrcTAE/bhGEU0E2VyPRwe6MKPZfAGvHZa3LrDOUZaRTv4KegovdRSQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791821285;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=jL0gHi/c1SLyJ0gXK3ALJUHc+le+FMaXJvbaOx42ze8=;
	b=rOBWINXphW1uAEabT9EpWahjyh5lx3IuGvf12JOGOX8O5xAzfdYaPQVK6AHj1QN55yND
	 E810jEaWnOga0/L0nss4SDmiKCmAZafxk9bWaW1WD9RSWMuLx71na41p2d09nVLJeLeaL
	 X1L6yZFLuI/TR00diFdeQ4plc6+XhGzhBiTbcTWJfhH3XllEIqdztOZcbk60EX1d5+5nK
	 gHB03TvRssc1WuVHJSH1j+ANI3cRmzSlyiLdLFdrvGtvoeP4XqOkbtJSfemJRbCKokRvq
	 aF2UkUgLfueS2WFOMjFK223iSVpGZG4LG6rjjpUx8aFmpnw9ddJaACvjKTycwePNRkA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791821285;
	bh=jL0gHi/c1SLyJ0gXK3ALJUHc+le+FMaXJvbaOx42ze8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aPYWr7lFTM/H/mrDsB8eCNbklvdn1rqv3jwuCZVLt4NmZGzeCVHMaU97VTJHws76S
	 opINdDmC434a8wSKUa6DUq1R9ib1Ew3RG7dZ9otzEV8LAvjTKG86beqOeRrcGibFh3
	 p9RxCzb/r/J3hN6ecGkEyBLapKQw3s6Auz8TxRVOd+dKKUG6vy/MqjZqqzopMEsT+Z
	 mXC3UAzDNBJOS7WnaYOo6jATQyvKMpVcXAAc2EYo8fFO7YihQAToBMdB2GxZqz6Kbf
	 f4q6V8M19FsFV0+d0d/32c7utmkn0gVXcVBGdiuEyrtljCAwT5uZLKgvooCE3B2lec
	 wqytjfXiGzURA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA3F340556;
	Mon, 12 Oct 2026 16:08:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 491FB105
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:08:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FE6740201
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:08:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ge21uSRpPHLr for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:08:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BF10040200
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::636"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791821283;
 b=AO3i9TQIcfgIK5E2w7PZQEdJqv2j05JpKXa/c+b9/TbaINwXuqmjXYnV3YiNgCNvKNHM
 52HKREftysTI+yJfweMwMVrZ5R1raBCmR7TbTe/cNTn8/CU3Pd9BBkDwfoVdQLr35bvFZ
 xDHofDG9+EDhbiXJ9VX9Blv6wiEzF02EtTBiwbRMCCbFZK0d1dIcBtFS3QLPBpZKuqmUT
 SN6LHrrLq3x5HDNRr90jhNQZEjjdUAnH0CLTrpHUVayJljrOaLew4T2rkoeucnKsaPM47
 viWY7467it/IA6QRTm/7MHnfvYm++wKKajVfecCv5OLqzFFUEOQVIuSKzrIOOhiebgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791821283;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=jL0gHi/c1SLyJ0gXK3ALJUHc+le+FMaXJvbaOx42ze8=;
 b=jdKzbgYw8Xrk+5j/v6Gm/QHPgntJtryrL9tMhQUDQXBRuy+2urD1IXqARicjuq4NfPgt
 ZOZSZFE/u3GnwD43dCLskbu5dgwWpex2+nLZAnifufai2tSZBAbn11T83wGs2ER5CeALp
 ABTRM7iPp55ZizjNTJ3kHn/93MNQjA237A7bVcrFSlk5851pmVeybHnagU7J2pdCJegH7
 jsRBE9584vo45grxvhllEJdNJ6cSCspotCEgdweGW+azVtZa/pEdW/Xk+ml/dww008uwQ
 VLg0TJw16E5iNO2g6wD1GZ+SxDjgXNlODvAfL7yQ0VkqVl4EewmFJ3HD6B/whSH/+9A==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XB+pr6cl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::636"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XB+pr6cl
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF10040200
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:08:02 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c360ab7a6f9so80926766b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791821280; cv=none;
 d=google.com; s=arc-20260327;
 b=oJrz3TDOKzMuh84d2V6tY3Ix7iftLIrrNEF3Wi0mGng96ji3CvNXDdRY8b4AP1FmTT
 KHvh+Hk7sYzOP0YCpxPlq4QwHl56RrdkeOAjVXW58sT72lkgFkKpMzaNli5X1B9TUGOC
 1Le80iBG82xWOH5VdK5xvCZdJTt4OHm1Bw6YX+2Td7DlMrEk8hjcBEaXuUBHy1Wqjgv7
 YEI9zIPa2NQeA3qdUGXxySMFRH6T69iabzw1/J2qPTQlgnFnyBNhNgFSlYequOueMyOI
 Fxlh+aiRXyuo7h5jE19r6vHB8rvCLazYVn4Vm//b7nOuKb+NXuxt3m6wJdXId2/WB7Hr
 T9fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jL0gHi/c1SLyJ0gXK3ALJUHc+le+FMaXJvbaOx42ze8=;
 fh=yGXDbT7MaF4SIksQ68riWnHQq7bSovbUxUoL7hQ44fk=;
 b=ehULE7v5BVdUgsRpTZ+WtQ1hrBlGqDhtk64lxZ/FLt6BJyNBwsgA9jOmnAJql/EqZ8
 oAonlW/0bBt+pmmJgRXyaBHdYfWHUftbwlgW4O1N9/CQHGak7rjRZc35ODG1ABgF3Qj7
 8VC8Tq47XgixrsRtTqgu5m/mYS7/2b9v3eg4mdW9AypwWtpqse39b3KGHkXuAB1VAbt4
 yVs6xiR6Xb5QNLGgzINs7f1aGdBnjkatqV5bgRQMeEwPpdOdJGYJaGIhAzBojwcyz04S
 mBaQho7beOx2/UHYxW0/UMOTh7NGCkRKTj5Xxt1L9mN1z7GIuRS5bCqBroiQnr2mmLGV
 zaQQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791821280; x=1792426080;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jL0gHi/c1SLyJ0gXK3ALJUHc+le+FMaXJvbaOx42ze8=;
 b=XB+pr6clY3Trt2ijMVS/UTRMPH0YXiQ78XdLxQzJBUQErpsbL7Z54Pt3hbkjGxpCPp
 yUsAXS/pR/Ykw+NWeMmTEWxFgIeEN38ud+ZJaYFMbu9OOyproqBOpwJPSOODjSpZ1JMW
 yxdNPFUcCpEbQTddkfuuyf03ArjC/dYgpLWV9PnNrony3qoqAc3kmbdbfzKrh9kwPeaR
 MrICtTFs0h+yb8mL/FIf6CRCI/rVebtruFuVqvgHCfuwjq6KgMMdDVlNonKuTIW7AE36
 1nJVLeqXEcs/aQPOV+irBQd+yDTu59f3suSQT+9H4OZVFHubHQxWHhIWVEKiWhvw0H8M
 ppfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791821280; x=1792426080;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jL0gHi/c1SLyJ0gXK3ALJUHc+le+FMaXJvbaOx42ze8=;
 b=jM4CjDMpZcEjlb3J2+Z5NUH2xxnyH5l4hwrlaTdT7lrVplnnHRzMkgwBIQj411LLci
 nb8Hp9QuvOEUQIjJtohPcqOLEVmEmGsCTdDeKc8/9uP55Un/VfnH9XQcQj4PMyJW8FhX
 2nfyIlF78Ob8ZMcFRV6IUf8OJnpEwChyVSrNqxz9Y3Y8yDgRw5BWTuzrbioZyvPpTLwQ
 OD4k9U84xD1igRh4+w8HuFCUXmGMv88DPxlMUjpg4faBy4/sGhKGtq2jE7xJVsBlqvcG
 PbNTh3b6QDwuCZccPuARTPnADve8h97G6IbahdnkXG3poFdvUuCyxlmDo8OqWCXGnX5x
 K8HA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4U203LjS6FC5cNIgZI4EnFULodW0xx7NHTivmQ5mF4wdw+Jq0oMm/aedPzNINdIEOIpPWMr4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLQtsRQ4AghVsf7k/iXoF9R6fm0BAwswJJEvfxlQVV+xqGQ6dyG
 /4mOQdPxr+NUOFMcmcVLIVEtBBdv3Jamcix+aixixrDuS9MttBD7QDa/SeXH42FrFX2Nv7YEjh8
 CtGfyjR+HBCxYyzys6b3SZ/wPntiWaHk=
X-Gm-Gg: AYBFou1U+vxt/zT5uQ2htes1GQks7i6rtCJmk+LrMi6h2UMMITwk6oREO9LGUFBZSfV
 8wItdcOWerK/g7LNkfZ/MVoLvXO8Oj3zddaguvpOH3fqYnybWslf5IkZ8+7XRqPPkEiwRrJi5RD
 Y1k95ilPNguM5Q6cF7uHLlUgiCFvZbxGeRahDowgx04iEIgtYoIhT7+cnYr/YMlq16beQgjlddR
 VRgoNP/ga1/HOhP6VhjYwDb2ANHLzqaOLR+ztQaV0FisSClV88KjX4kM7hvqfU1l1AHS0pQSFhH
 kiq7tQ06X+e4f2Fq2mQACaNc+07G5VxOgZOXGdkPKNBLz+/9YfYnxBY=
X-Received: by 2002:a17:907:720e:b0:c2e:51a9:ea7 with SMTP id
 a640c23a62f3a-c31aa0bf634mr996147366b.48.1791821280029; Mon, 12 Oct 2026
 09:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
In-Reply-To: <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 12 Oct 2026 21:37:42 +0530
X-Gm-Features: AclHuK-P5C8YFPjg0rgvyi_IkPVgSSM9hmRV7M3IQxnK3n1xRpuI5Wy30bqXl_c
Message-ID: <CANAwSgSSbmQu0jzJQW1-4ZBSxUXnBD87svNa+fqyiEwF6JhYDg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Dave Klotz <DaveWK225@protonmail.com>, 
 Yixun Lan <dlan@kernel.org>, Eric Chung <eric.chung@riscstar.com>,
 Peng Fan <peng.fan@nxp.com>, 
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
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

Hi Zixian, Tanmay,

On Mon, 12 Oct 2026 at 18:49, Zixian Zeng <sycamoremoon376@gmail.com> wrote:
>
> On 2026/10/11 22:31, Kathpalia, Tanmay wrote:
> > Hi Zixian,
> >
> > Thanks for the logs.
> >
> > I hit the same pattern while testing the Cadence SD6HC driver.
> > Multi-block reads failed and single-block reads worked. On that board
> > the host and the card were in 1.8 V mode, but the I/O supply had been
> > left at 3.3 V. A short transfer got through; a longer one failed on the
> > data lines.
> > Both stages on K1 use the same PIO loop, so a FIFO that drains slower
> > than the card delivers would show up in U-Boot proper as well. Your
> > SPL/proper split fits an electrical setup difference.
> >
> > The SPL failure is irq=408020. Bit 22 is the Data End Bit Error (EDEB,
> > SD mode only): the controller detected 0 at the end-bit position of
> > read data on DAT, or of the write CRC status. That is a bad edge on
> > the data line during the transfer.
> >
> > On the Banana Pi F3, aldo1 is vqmmc-supply of &sdhci0. The U-Boot
> > dtsi names it vdd_1v8_mmc, and the SPL prints "vdd_1v8_mmc,
> > value:1800000" before MMC2. set_vdd_mmc() in board/spacemit/k1/spl.c,
> > called from board_init_f(), writes 1800000. The dts leaves aldo1 at
> > 0.5 V to 3.4 V. SD High Speed (mode=2) uses 3.3 V signaling; 1.8 V is
> > only after a UHS switch. mmc1_cfg is power-source 3300, and
> > mmc1_uhs_cfg is the 1.8 V state. For this mode the rail should be 3.3 V.
> >
> > CONFIG_SPL_MMC_IO_VOLTAGE is not set, so mmc_set_signal_voltage() is a
> > stub and signal_voltage stays MMC_SIGNAL_VOLTAGE_000. aldo1 stays at
> > 1.8 V. U-Boot proper has CONFIG_MMC_IO_VOLTAGE. mmc_set_initial_state()
> > requests MMC_SIGNAL_VOLTAGE_330, so the driver writes 3300000 to the
> > same vqmmc-supply and clears SDHCI_CTRL_VDD_180 before the transfer
> > that succeeds.
> >
> > CONFIG_SPL_PINCTRL is not set either. The driver calls
> > pinctrl_select_state() under IS_ENABLED(CONFIG_PINCTRL), but that
> > function is a stub unless CONFIG_IS_ENABLED(PINCTRL), and the return
> > is ignored. SPL never applies mmc1_cfg. Proper selects "default" for
> > SD_HS, which is that state.
> >
> > Keeping the multi-block path, set_vdd_mmc() to 3300000, or enable
> > CONFIG_SPL_MMC_IO_VOLTAGE. If the 32-block CMD18 still fails, enable
> > CONFIG_SPL_PINCTRL so mmc1_cfg is applied. If either makes the read
> > succeed, this is the F3 failure.
> >
> > Regards,
> > Tanmay
>
> Hi Tanmay,
>
> Your diagnosis was right - it is the I/O voltage.
> Enabling CONFIG_SPL_MMC_IO_VOLTAGE makes
> the multi-block read work on the Banana Pi-F3:
>
> Based on previous commit, I patched the following changes:
>
> diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
> index 9c15d96eae2..f5c717e5965 100644
> --- a/configs/spacemit_k1_defconfig
> +++ b/configs/spacemit_k1_defconfig
> @@ -95,6 +95,7 @@ CONFIG_MMC=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_SPACEMIT=y
>   CONFIG_MMC_IO_VOLTAGE=y
> +CONFIG_SPL_MMC_IO_VOLTAGE=y
>   CONFIG_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_HS400_SUPPORT=y
>   CONFIG_MMC_HS400_ES_SUPPORT=y
> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> index 23c655c6def..58374c482b3 100644
> --- a/drivers/mmc/spacemit_sdhci.c
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -251,6 +251,10 @@ static void spacemit_sdhci_set_voltage(struct
> sdhci_host *host)
>                          bool ok;
>                          int voltage_mv = to_180 ? 1800000 : 3300000;
>
> +                       printf("sdhci: voltage signal_voltage=%u
> vqmmc=%s -> %dmV\n",
> +                              mmc->signal_voltage,
> +                              mmc->vqmmc_supply ?
> mmc->vqmmc_supply->name : "none",
> +                              voltage_mv);
>                          if (spacemit_sdhci_set_vqmmc_voltage(mmc,
> voltage_mv))
>                                  return;
>                          if (!IS_SD(mmc))
> @@ -274,7 +278,8 @@ static void spacemit_sdhci_set_voltage(struct
> sdhci_host *host)
>                          break;
>                  }
>                  default:
> -                       /* No signal voltage switch required */
> +                       printf("sdhci: voltage signal_voltage=%u -> no
> switch\n",
> +                              mmc->signal_voltage);
>                          return;
>                  }
>          }
>
> Booting logs as follows:
>
> U-Boot SPL 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
> Fail to detect board:-2
> vdd_core, value:900000
> vdd_1v8, value:1800000
> vdd_1v8_mmc, value:1800000
> DDR firmware: [0xc081d880]:0xf0227179, size:0x8d98
> DDR is ready
> No SPI controller (-19)
> Trying to boot from MMC2
> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
> max_clk=204800000
> sdhci: voltage signal_voltage=0 -> no switch
> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
> mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef
> cmd23_host=1 scr0=2358043 cmd23_card=1
> sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
> mmc: multi-blk blkcnt=1956 clk=50000000 mode=2 width=4 caps=300207ef
> cmd23_host=1 scr0=2358043 cmd23_card=1
> sdhci: multi cmd18 arg=1000 blks=1956 blksz=512 mode=32 dma=0
>
> <debug_uart>
>
>
> U-Boot 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
>
> DRAM:  4 GiB
> Core:  338 devices, 22 uclasses, devicetree: separate
> MMC:   sdhci: mmc@d4281000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
> max_clk=204800000
> sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1
> max_clk=204800000
> mmc@d4280000: 1, mmc@d4281000: 0
> Loading Environment from nowhere... OK
> In:    serial@d4017000
> Out:   serial@d4017000
> Err:   serial@d4017000
> Net:   No ethernet found.
> =>
>
> With the voltage corrected, a single 1956 block PIO CMD18 loads
> the whole FIT,so the controller is fine with the FIFO back pressure,
> the slow SPL drain was a symptom, not the cause :-).
>
> Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
> "sdhci: voltage signal_voltage=0 -> no switch".
> Since mmc_set_signWith the voltage corrected, a single 1956 block PIO
> CMD18 loads
> the whole FIT,so the controller is fine with the FIFO back pressure,
> the slow SPL drain was a symptom, not the cause :-).
>
> Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
> "sdhci: voltage signal_voltage=0 -> no switch".
> Since mmc_set_signal_voltage() is a stub in SPL, so mmc->signal_voltage
> stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
> "no switch required" path, and aldo1 stayed at the initial 1800000 that
> set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed
> after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is
> what hid it.
>
> On the pinctrl side I had already run the SPL with standalone
> CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
> mmc1_uhs_cfg plus their pin groups. I confirmed that
> pinctrl_select_state() return successfully. The multi-block read still
> failed the same way with the rail at 1.8V.
>
> Therefore, I suspect that configuring the MMC signal voltage to 1.8V
> in pmic_init() may need to be modified.
>
> Thanks for your suggestions and guidance.
>
> Best regards,
> Zixianal_voltage() is a stub in SPL, so mmc->signal_voltage
> stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
> "no switch required" path, and aldo1 stayed at the initial 1800000 that
> set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed
> after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is
> what hid it.
>
> On the pinctrl side I had already run the SPL with standalone
> CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
> mmc1_uhs_cfg plus their pin groups. I confirmed that
> pinctrl_select_state() return successfully. The multi-block read still
> failed the same way with the rail at 1.8V.
>
> Therefore, I suspect that configuring the MMC signal voltage to 1.8V
> in pmic_init() may need to be modified.
>
> Thanks for your suggestions and guidance.
>
I have also made some changes related to SPL GPIO and pinctrl support.
On the Banana Pi BPI-F3, the MMC controller uses the following
regulator references,
which are not currently configured in `k1-musepi-pro-u-boot.dtsi`:
vmmc-supply = <&buck4>;
vqmmc-supply = <&aldo1>;

To address this, I updated `k1-bananapi-f3-u-boot.dtsi` to include the
required regulator
configuration and make it available during SPL initialization.

Could you review these changes and assess whether they can be integrated
into the mainline U-Boot code? I would also appreciate feedback on any
changes needed
to make the implementation suitable for upstream submission.
> Best regards,
> Zixian
>
[1] https://gist.github.com/moonlinux/2ae03be59f263b0797acb138bed226b5

Thanks
-Anand
