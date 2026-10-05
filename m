Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8ED7CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59B6E40620;
	Mon,  5 Oct 2026 08:01:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sHC3HER_EUKS; Mon,  5 Oct 2026 08:01:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AD4104061B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791187305;
	b=suVEn8ODZoJbBYLO26ju3KXm4qLmnEDkAaOlajbtfUW6Ofm+XnPgozlJwQf8b4+eWN1b
	 q0k1mECJST1DfeYZ3s36XoEzu+NM1YwEA0U9h7KGhcsmZWDT6/kNZdOMhb7mlGy0mhN9N
	 9GAWynzkvt8yME2dI+BgQiVX3V6Byle+K2oe0hsx/QnOHyMsvTRSPaqUo4UqYhH2OaDU5
	 Q+Wf+2dcyzVZcg8vabgoXCryhwDwv5Ralx3FAVmBbMiAsuhjR/jb+lv3Hsn9I+MSjr3Cf
	 Yhvf/faIBNYiXGToyD7qskmioXhwIc0e9NPrl46K31h7RsNuPdudOUHu4GWc0D7aevg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791187305;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ho6wUO7HlM9+2ZSzhp7FELZbuU0kkwsvZd2HmRWrRSA=;
	b=ilqgcvWc8LrOUTQqW6/gggYSn3F6BJJOPCLc5aZn3MR0z8kRO8SLuZZsRpj1Wcc8bwi3
	 QRAFMiFER5iLVo5ydIf36YMVu4VUp94PRgykGEsBWmkatl+uTF/JUOxdakFTz0u5Uz2l2
	 4ZbuHqYhV+zhzmemxfSadMOyBR6T2wsu5pBQrDbhxouhwmpmcGBfBXerN9QHdDmn7PXtD
	 ipCfBeeIqSwxF/hsHSqgBj+afHyGhuJdgcq5g/j1qFqK/dfgnTcLfXY6IwWitZfx6uY4F
	 9v0LZfQJkl3KnaGgViH5grnnW4+1ECGV3U3bsrjBEgD/mqICpQeHQD6s6C1AW7H3m2g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791187305;
	bh=Ho6wUO7HlM9+2ZSzhp7FELZbuU0kkwsvZd2HmRWrRSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Emwrdtp66zzWDveaiQn13fclGZpJm+wqNNzAh1gH6bn3nNw3cwUXip84psRK9SZAm
	 48t8KKmVIDXH7wbTc94icUgNAh66Jdj/s9LDDNPmGiHZy0tyToEPbmjvOPq5XwcVkb
	 QAm3WjEbvC7C/07rVTGfx+t9yDFoI60di8KoG2qbIsr9AS1kCjrJSbgSlYBR9chYpM
	 C8gTZsRDMrkDVzLYJybF7wNlHF4YoOFY5qCymZEz0inCzNlhEhVHVjOEFSD64qVpSx
	 JzR6G3nr+YfRvGB3JgNouIHOvVkea4H6rk5gt2qSYydoaoHi3yA+WQLVhqlbONR46y
	 zTmOPJD1DLoTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AD4104061B;
	Mon,  5 Oct 2026 08:01:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 048BC34D
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA66D60611
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jQGejTHjjUBY for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:58:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 398F6605F9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791187101;
 b=feNQy0Z6u+hMBlzRfF3SppPJQr0bkdy+g7gNYIEaJbGqAa/zQBMZ5arKmjuclb+qnxMu
 HljkpAogWsiIR6DskDGT6P8REBHDwmwx0tqI/KGrshwURLrprvbr2gwd1zKxB4cPlwRZ8
 SfI1JWgDLNE4aodGkn3KpuEC/dyuumjo46a0cAGfjKaJaqpYcLP8mcG9CuAptzsl+XaRk
 z04EV5kDF3nQwoWDvnDPH5N0weY4cIqOKKauoMwwf6BkHlSA3LToVS1z1xWPMk+/kkuvO
 dR0YS+CeUVqBuw6EsjjXdtHOqDwurb5CrNh7iuG5YVhKNSmIEnFSzT1I69QUpx7hKRA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791187101;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=Ho6wUO7HlM9+2ZSzhp7FELZbuU0kkwsvZd2HmRWrRSA=;
 b=QDM8/nCYCnQ+Q7D5bm8k4hvyxZwbedVzS1W4NK4Wk7mYBoUM8dEnQ8hriv2vPff3+7sv
 uxQrB7eGIVwOzPnLOm94Knl96n6Le343K4p2L1vBPDCBfyKn782qWixBGhFekwFVIy/Ks
 feQMK58E6VCg7c1dnuJawxY0ASCdcPHm4pLFVXh+i+Fd2C1ofJi2TpSz6nUS8H9NFUCC1
 8PvkYosC63+7klNp5kxUY25p2qoVUmnBZhRD6N64kpYe4ADtK75VSyF3d98+1eWVXqGE3
 JcjhaCPjmg+/481opdww2N/GGgqBE4zQU9LNordIzE/l3jYQauCoSuM0OT317YVfFxw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=pv+8EZ4Y; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=pv+8EZ4Y
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 398F6605F9
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:20 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hysFj39BgzMlPR;
 Mon, 05 Oct 2026 09:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791187097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ho6wUO7HlM9+2ZSzhp7FELZbuU0kkwsvZd2HmRWrRSA=;
 b=pv+8EZ4YiY/BIgRmeSw9Mi0u07uTS+AcYzs0xhb8Eauu4f64M/d5CZpFj/ZKXU/Qj3h9B0
 MnSVMCshtDcV9LmqzPZKlSC/s6oYgPxidGOpqWpz6VrE5QuOVuU0d08hzPvDaaCexS1FVE
 1J0iXh0bbn73ALsaD8GUnmuwa90OeudyZ6rKtmAI1TTcDCO27l7s32cnp1/iGfXOqXVjKU
 waF9x32H8Q9Ivz8eW7eylctOoQ5Tidv2uQ4PqRkDQkiXCRVm8uCPVivXT2jNzr6NnrE1Ot
 gzlnX6D1J2ApbAu/veSIJ3H0gzit5bTciWb6wtBRno9hFj4tJy+ibzP3lr7yyg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Pengpeng Hou <hppiscas@163.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: Re: [PATCH] ddr: Fix the SPD EEPROM dependency for Armada XP
Date: Mon,  5 Oct 2026 09:58:06 +0200
Message-ID: <20261005075813.601288-2-stefan.roese@mailbox.org>
In-Reply-To: <20260906045032.28384-1-hppiscas@163.com>
References: <20260906045032.28384-1-hppiscas@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7xot1b5t55zu3wjwhzqwydwrmbu1xt34
X-MBO-RS-ID: 3dabcc6a4f1b8ad6a41
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

On 06.09.26 06:50, Pengpeng Hou wrote:
> Kconfig expressions use symbol names without the generated CONFIG_
> prefix.  SPD_EEPROM currently depends on the undefined
> CONFIG_ARMADA_XP symbol, so the Armada XP branch of the dependency can
> never be satisfied.
>
> Use ARMADA_XP, which is selected by the supported Armada XP SoC types.
> This restores the option for boards whose DDR setup reads DIMM timing
> from the SPD EEPROM without enabling it by default.
>
> Fixes: 8ce59b593294 ("Convert CONFIG_SPD_EEPROM to Kconfig")
> Signed-off-by: Pengpeng Hou <hppiscas@163.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
