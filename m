Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE003CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 13:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3582B40580;
	Mon, 12 Oct 2026 13:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRcKTgb9RjHE; Mon, 12 Oct 2026 13:19:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B652240555
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791811192;
	b=qU5TPEZg3efHsjCBPt1/dCdxlRH8CSlEkotKMKKVphwshqC/lk6LjADV4vMHpEzb79Zc
	 IHr0iuQHalkDkymMoIz8XXAxZPO30LlttHY1XjurvpdrmnT1DZGAIFLmAyVmWdyCprHk8
	 FVrWCGlx5ntGwXlwy5QfbKC+JLlum9m6OJeLQMugf0F1IADN4JVZtG6zOUWl/RG5+EFcX
	 3aeKgUUI+BgyHrUgVs2+AMaLJlwuHfkbVcBaa/e82hiKemWijzZdUGNPDqdzwX0s1HMH4
	 r/4pxk+yaVtpsAFvhaKrZfsxM7OpuKH+Ma3majVlMz7foCk+vz8mfbLU+21MpPUYZoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791811192;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oH9PI5IH0mCbAyhRfr2b3DT6H2ImZN7dhfbXyytYI6c=;
	b=lpnzxMxzq6uyP74RWfrHWnpXX2oCqjvIDkD2PfLypXBmJjCW9mRFIcrEMbtMuj02fPOx
	 v355RUOaiqpfcI035WUQt2UgOB+14GCUAZnxn8v/2UjlGTzv5suQRCtO1ZJoOldiXJMpp
	 42S6nrkTn+hxaenLxI3C64twzslRZc+KntzFmqBBSRv2bTxpNbMbhqDLXMBQtoRh0ThAZ
	 zfYJ3cuZlGiBg40P8YCONmA80Q00FOqwUhiSQOWyJQND1UukFz3jsi2fDqdlS0ZRgoeVe
	 CXo4GoMGyCxVVOhqe1ItUf0GLcvTb87E5RRC8Kt5A1UJwlCGbjO+hsT/xttLwBDqPrg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aQTMwl4W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791811192;
	bh=oH9PI5IH0mCbAyhRfr2b3DT6H2ImZN7dhfbXyytYI6c=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VkB4to4jWTKefPPS/qUxEZb6LK1txlixIbWRUHa0aUqfeo24tZR3N3NzmedlxN93J
	 X1GWjLx8OcqzqZkF4JSsaUxxqg0u+Vnss/jx3X0SYLHq2d7LyuL4Zfh++kXGGoZqVM
	 OICorcEyZw3i//ZvLcWAVEBK4lusxWQ/78vb+1TP1f/U1sqjwIfjOM8CwEx9pglD7H
	 2TvNK+duJt7cKS3zjytNeYFbhoq4FTdJyLc6WX0oLv98O7YuFdUlSjgTGSqZRG843X
	 hPKRygnyvkvFaaXpN/DDAgWrrltQiD8iJkKBNRzVDrMRdouJYsiDRSJWb5qAD0+FCy
	 v3HdAlGoBWnrg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B652240555;
	Mon, 12 Oct 2026 13:19:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4DDF9156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D14C40509
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:15:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYJdhKQdbFjW for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 13:15:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D3C740478
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791810931;
 b=KSSNlrSEdxkHTJIYaCL1pGhXr8U5PCAgp79vF2uquMcWhxEG7YOuZ1FcLMIoYaTaWuIU
 gTijZHQJUhdlfbV3f0FARfUmVK/T/Yp8rH8A78C9PFndmgtgSkAk9CK6DveiMYvYF9WSP
 U43WMO3L179HcZKPTOSyuzopTOt1dsa6W5bo14nmS9tNi3tUgI9dflDbTAFR7OsUrmJzg
 sbDRklN9+Se7UMLuNv9XfaPEFHuu2bzcVFVUVL7ooYXXJQcv8uYfAXdYm/CO4HvFGEwnU
 a3T98DVlMqbCyKuFm5fTPbyB8u2PR9kZqjLp5n8g5ijKz5T/NTfgO+AUtWsjsR8qe2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791810931;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=oH9PI5IH0mCbAyhRfr2b3DT6H2ImZN7dhfbXyytYI6c=;
 b=Hwn4Ap64VdTB1vJ28rve91L1H7FjDx5SCWv9FIx7I/fPAt+h1M6G3PTTVaU3KWzSAGhB
 J+Sl9VT/zXWmhTyZIwFXF+vmiJT8a0p47DJmin/MsCsx8PbBF1kDZ+I/CC/m4bopr48rs
 8THZshmy90dxqyJQvREMdahlkxbxk4fO+GjN5s/qiyBLWSoGLXbogIorykr97QrBrvE0n
 P3l/NDqjOo+cl0TV1Y+8XlbCReNSO47UGzhTZzD8iM+oLQsewWhTBzdPw55L2biMb3zNR
 WycJpQVzHw+6ILWRkfqN9y/t4Fc4EVuOmSnqachpI/RY9OvedmXW9gqfjfldKN0j0OQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aQTMwl4W; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=sycamoremoon376@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aQTMwl4W
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5D3C740478
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:15:30 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cd6028ff33fso404679a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791810930; x=1792415730;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oH9PI5IH0mCbAyhRfr2b3DT6H2ImZN7dhfbXyytYI6c=;
 b=aQTMwl4W7k4LbFNsFiiW+kEDspjV7CXhSZI8ckJ2KrX1lZ8bRVX/RAY3RjpHs36czC
 NK2yTSgmugwAfVLlKaatfhgPvyxPKwCZ0Hp/Rt8auW7DnGSeDImf6OvwxYpJGu18oPaZ
 1XyzaYA5yau0+LK1hSp2eQwZNlFZ3RQYADLTp76dzAlDG5blnX9lrAHQZR2n6poHEzfS
 ASMf59WTs7zj4SlvdeklLvJXtNydHzMuH3OIRVS3F9ls1rUr87yKXk3DxSpHZ2kxQ4WW
 +SdXrxHU0AMBoIm4RpMRpOVfMJwUaTTd7VAj9B89OE5P4BJzfoA7KPMQWbirnUf3g7Ll
 MdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791810930; x=1792415730;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oH9PI5IH0mCbAyhRfr2b3DT6H2ImZN7dhfbXyytYI6c=;
 b=HaMb53uxbET4Ess+iCr6W8yEELaoCkCmET3dryvyr05uWIWU6djhUKw2uWmssZuOz+
 H4qbt6LJa/wmww8Uqrb3dNpiLNRzs1qgYsfC+f7k/Hftk91M9eNf6dcIZNQzhXl0YHSi
 rOIRngeDZZlXQUPB773j3w6dsaLAyD+vBcouJksOgDokJXK7qztL36/C2q/b23AgCaC2
 0gyNwdlaCpGz2/3JqM3BxYMWrxYid2n3GrsUstrn6zpnjl1cQohFyKRBGuog1fCy6boH
 s6yPVAvWbE8de2iQbKyT2kHQa2eU6/NJCfisedhZdnjiI9dnRmhq647Na+2OaJ2FPLJX
 DhZg==
X-Gm-Message-State: AFq9FYKgLB4jMnOY32gFHCi6N2ZwVqQ/lJCJ/tyfV8o0+Vn6paMb8DKo
 yHIW3c4/0MoTyi2Snv1YaW2uLfTfUHoRk9g+gYyiGeNxjo2cowGHTtj2
X-Gm-Gg: AYBFou3A5tBYFA+JeTrGvp5bxY/w8c0AeOHFIxN68Iph7ipEtCENcX0qMQ07JE5H7ry
 lrQxlwzlfDablARtFETxptdAXq56DCranABU4B5HQB9eL/Ia89BkdEu8H1Sug84pAxPMCC6PDCx
 c7FTcE3PWPgglnt1e1Dpo/rajjh8hwWUuiA/SuLckCa4hrWzfZ4oJiCXrVaVpC+ISHLStrHMnSJ
 VTbzO+oFz3USh2vLzW3OD/Y+1HUfuUzo2gS9AWNCPcAeZawSyNk7J1Nxo/QmNjVqmIxlRPC/n1/
 INdS94jX2rTI447v3ZUvPK/ZuxE7rIEhpw8PFMY/HFrpE24wA2eMvympAH8ocQcQI/LIkTVRStc
 6gF/EIhEZ5fmz/BcxFcHfaidQgQrIl9TwpWad49LK7tVmjxI61A/hbo9mUJqCA0Ir/orSktel8Y
 HwMSqx6Psp4dxOpU04SAPXVaajFuHMKfAV5xPXe1RDgISlnys8dqzIlR4kTLQKecR7SYl0UaJH
X-Received: by 2002:a17:902:f708:b0:2e2:d09f:d770 with SMTP id
 d9443c01a7336-2e842ab67c2mr88768435ad.26.1791810930142; 
 Mon, 12 Oct 2026 06:15:30 -0700 (PDT)
Received: from [0.0.0.0] ([20.89.104.82]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422c9944sm43543525ad.64.2026.10.12.06.15.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 06:15:29 -0700 (PDT)
Message-ID: <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
Date: Mon, 12 Oct 2026 21:15:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Zixian Zeng <sycamoremoon376@gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
Content-Language: en-US
In-Reply-To: <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 13:19:50 +0000
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

On 2026/10/11 22:31, Kathpalia, Tanmay wrote:
> Hi Zixian,
> 
> Thanks for the logs.
> 
> I hit the same pattern while testing the Cadence SD6HC driver.
> Multi-block reads failed and single-block reads worked. On that board
> the host and the card were in 1.8 V mode, but the I/O supply had been
> left at 3.3 V. A short transfer got through; a longer one failed on the
> data lines.
> Both stages on K1 use the same PIO loop, so a FIFO that drains slower
> than the card delivers would show up in U-Boot proper as well. Your
> SPL/proper split fits an electrical setup difference.
> 
> The SPL failure is irq=408020. Bit 22 is the Data End Bit Error (EDEB,
> SD mode only): the controller detected 0 at the end-bit position of
> read data on DAT, or of the write CRC status. That is a bad edge on
> the data line during the transfer.
> 
> On the Banana Pi F3, aldo1 is vqmmc-supply of &sdhci0. The U-Boot
> dtsi names it vdd_1v8_mmc, and the SPL prints "vdd_1v8_mmc,
> value:1800000" before MMC2. set_vdd_mmc() in board/spacemit/k1/spl.c,
> called from board_init_f(), writes 1800000. The dts leaves aldo1 at
> 0.5 V to 3.4 V. SD High Speed (mode=2) uses 3.3 V signaling; 1.8 V is
> only after a UHS switch. mmc1_cfg is power-source 3300, and
> mmc1_uhs_cfg is the 1.8 V state. For this mode the rail should be 3.3 V.
> 
> CONFIG_SPL_MMC_IO_VOLTAGE is not set, so mmc_set_signal_voltage() is a
> stub and signal_voltage stays MMC_SIGNAL_VOLTAGE_000. aldo1 stays at
> 1.8 V. U-Boot proper has CONFIG_MMC_IO_VOLTAGE. mmc_set_initial_state()
> requests MMC_SIGNAL_VOLTAGE_330, so the driver writes 3300000 to the
> same vqmmc-supply and clears SDHCI_CTRL_VDD_180 before the transfer
> that succeeds.
> 
> CONFIG_SPL_PINCTRL is not set either. The driver calls
> pinctrl_select_state() under IS_ENABLED(CONFIG_PINCTRL), but that
> function is a stub unless CONFIG_IS_ENABLED(PINCTRL), and the return
> is ignored. SPL never applies mmc1_cfg. Proper selects "default" for
> SD_HS, which is that state.
> 
> Keeping the multi-block path, set_vdd_mmc() to 3300000, or enable
> CONFIG_SPL_MMC_IO_VOLTAGE. If the 32-block CMD18 still fails, enable
> CONFIG_SPL_PINCTRL so mmc1_cfg is applied. If either makes the read
> succeed, this is the F3 failure.
> 
> Regards,
> Tanmay

Hi Tanmay,

Your diagnosis was right - it is the I/O voltage.
Enabling CONFIG_SPL_MMC_IO_VOLTAGE makes
the multi-block read work on the Banana Pi-F3:

Based on previous commit, I patched the following changes:

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 9c15d96eae2..f5c717e5965 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -95,6 +95,7 @@ CONFIG_MMC=y
  CONFIG_MMC_SDHCI=y
  CONFIG_MMC_SDHCI_SPACEMIT=y
  CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_SPL_MMC_IO_VOLTAGE=y
  CONFIG_MMC_HS200_SUPPORT=y
  CONFIG_MMC_HS400_SUPPORT=y
  CONFIG_MMC_HS400_ES_SUPPORT=y
diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index 23c655c6def..58374c482b3 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -251,6 +251,10 @@ static void spacemit_sdhci_set_voltage(struct 
sdhci_host *host)
                         bool ok;
                         int voltage_mv = to_180 ? 1800000 : 3300000;

+                       printf("sdhci: voltage signal_voltage=%u 
vqmmc=%s -> %dmV\n",
+                              mmc->signal_voltage,
+                              mmc->vqmmc_supply ? 
mmc->vqmmc_supply->name : "none",
+                              voltage_mv);
                         if (spacemit_sdhci_set_vqmmc_voltage(mmc, 
voltage_mv))
                                 return;
                         if (!IS_SD(mmc))
@@ -274,7 +278,8 @@ static void spacemit_sdhci_set_voltage(struct 
sdhci_host *host)
                         break;
                 }
                 default:
-                       /* No signal voltage switch required */
+                       printf("sdhci: voltage signal_voltage=%u -> no 
switch\n",
+                              mmc->signal_voltage);
                         return;
                 }
         }

Booting logs as follows:

U-Boot SPL 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)
Fail to detect board:-2
vdd_core, value:900000
vdd_1v8, value:1800000
vdd_1v8_mmc, value:1800000
DDR firmware: [0xc081d880]:0xf0227179, size:0x8d98
DDR is ready
No SPI controller (-19)
Trying to boot from MMC2
sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
max_clk=204800000
sdhci: voltage signal_voltage=0 -> no switch
sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
sdhci: voltage signal_voltage=4 vqmmc=aldo1 -> 3300000mV
mmc: multi-blk blkcnt=32 clk=50000000 mode=2 width=4 caps=300207ef 
cmd23_host=1 scr0=2358043 cmd23_card=1
sdhci: multi cmd18 arg=2 blks=32 blksz=512 mode=32 dma=0
mmc: multi-blk blkcnt=1956 clk=50000000 mode=2 width=4 caps=300207ef 
cmd23_host=1 scr0=2358043 cmd23_card=1
sdhci: multi cmd18 arg=1000 blks=1956 blksz=512 mode=32 dma=0

<debug_uart>


U-Boot 2026.10-rc5-00643-g6a99fe92389a (Oct 12 2026 - 21:13:00 +0800)

DRAM:  4 GiB
Core:  338 devices, 22 uclasses, devicetree: separate
MMC:   sdhci: mmc@d4281000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
max_clk=204800000
sdhci: mmc@d4280000 path=PIO flags=0 caps_sdma=1 caps_adma2=1 
max_clk=204800000
mmc@d4280000: 1, mmc@d4281000: 0
Loading Environment from nowhere... OK
In:    serial@d4017000
Out:   serial@d4017000
Err:   serial@d4017000
Net:   No ethernet found.
=>

With the voltage corrected, a single 1956 block PIO CMD18 loads
the whole FIT,so the controller is fine with the FIFO back pressure,
the slow SPL drain was a symptom, not the cause :-).

Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
"sdhci: voltage signal_voltage=0 -> no switch".
Since mmc_set_signWith the voltage corrected, a single 1956 block PIO 
CMD18 loads
the whole FIT,so the controller is fine with the FIFO back pressure,
the slow SPL drain was a symptom, not the cause :-).

Without the CONFIG_SPL_MMC_IO_VOLTAGE=y change the same driver printed
"sdhci: voltage signal_voltage=0 -> no switch".
Since mmc_set_signal_voltage() is a stub in SPL, so mmc->signal_voltage
stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
"no switch required" path, and aldo1 stayed at the initial 1800000 that
set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed
after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is 
what hid it.

On the pinctrl side I had already run the SPL with standalone
CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
mmc1_uhs_cfg plus their pin groups. I confirmed that
pinctrl_select_state() return successfully. The multi-block read still
failed the same way with the rail at 1.8V.

Therefore, I suspect that configuring the MMC signal voltage to 1.8V
in pmic_init() may need to be modified.

Thanks for your suggestions and guidance.

Best regards,
Zixianal_voltage() is a stub in SPL, so mmc->signal_voltage
stayed MMC_SIGNAL_VOLTAGE_000, spacemit_sdhci_set_voltage() took the
"no switch required" path, and aldo1 stayed at the initial 1800000 that
set_vdd_mmc() writes in pmic_init(). The 32 block CMD18 then failed 
after ~20 of 32 blocks. Single block reads passed at 1.8 V, which is 
what hid it.

On the pinctrl side I had already run the SPL with standalone
CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
mmc1_uhs_cfg plus their pin groups. I confirmed that
pinctrl_select_state() return successfully. The multi-block read still
failed the same way with the rail at 1.8V.

Therefore, I suspect that configuring the MMC signal voltage to 1.8V
in pmic_init() may need to be modified.

Thanks for your suggestions and guidance.

Best regards,
Zixian

