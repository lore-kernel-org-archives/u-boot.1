Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7712BC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 37B5860762;
	Tue,  4 Aug 2026 13:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l5-NTxusWWOQ; Tue,  4 Aug 2026 13:05:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2955760715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785848754;
	bh=vFm+T/ETcyWAsma3YKUeTaFPeTTqZh6jakUluhChy/Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WUxbHHgN6ktFb2a5aC6Ac0yd+8l1qNQnmHxPtB+HaWDR5HwoDMDh0WHCPMNFUR1CP
	 OpTmEibjQxfoTv6wL61ytDXZH7HTotAoNdtzEwzWGRj9mNekJrmMvn88E+JYe83F0/
	 tKLY/2T1bG1xd6rD8Sb7AAjS8fFYF1exjzF39lITNioRWMAQuVuvx6+2ANl+RrgFwB
	 ajbOPVjBvuqz4nHy+AANsXXJpqhgPirMzVvbqHYnSrXh+8GbdY7uKm8lfSAtQoSmvY
	 Z63q2ikPJwx1/JQNSSYHNUk3hndHB4xouU6z6fkawTjBXDmqkyj2BXrDCv3aQFy/Lo
	 fZWPngrLe987A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2955760715;
	Tue,  4 Aug 2026 13:05:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AAA7C218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9184680B92
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YIopnmU6A3kQ for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:05:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5D95880C7C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5D95880C7C
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D95880C7C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:05:51 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69fab5a852cso6262184a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848749; cv=none;
 d=google.com; s=arc-20260327;
 b=S8iLhJvcGRVvah6LlEKmxZAy/Hok4973NtlY58N3A2TD8s8UYWxB0rLLiAu8Vx5f1Z
 eokkOyTISIDiS/On1I241rK8LC54rRbxiIVtBaOxd2o/BdogOJ21XPr90RBbWCEeBEuu
 ygb2S/cQYNM9rScKyJ0SMzGVMZo6W19iqRyB3O0kdJYyJWxT8BsBPwsWvXoU3qGTSFQv
 J1xSVfqu+2mbISeJY7EsWc5lzRl1hEiRS16HGNhsx/62x2xoX87zqDl1LAjQgWjp8miB
 yo7fI0C9TA1CivUE8UvTxQf6jg3RKDiywOu9D6kHYvt8KBMQbBU/Ac4xanR5k04JVhct
 FPOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vFm+T/ETcyWAsma3YKUeTaFPeTTqZh6jakUluhChy/Q=;
 fh=Kycz0RmuF12z7/MfMEx/C/XJlPwcni/aTJr26m8kUJU=;
 b=UrtWNHpskxlrr4y9Hj7JzsufvrACCJgrIx4RlGzBa2/ruQ40nGLCNFTetKvchpqjWx
 0Y+Fjrce+t9MBfj/vEAeZ6uuBbp0dVPXhSPUOy3GSkqEZx4BEV4OZcB/uHJAPRstkdpE
 ELLpiWRiUGBeyDX8vzGRrW9aRYivlKm6/ciWaF8TbUytOi5t8xChslJQpGJZ6NRnsYL3
 etBAABJihg/KWkvhOd1v51kKw4gog4L47nRHIw+eAbZVX8mdBHZkmPo6mAIlVXpfZpVq
 XV/BX5kwm557zCFrAYrVRQsmZV/ofRqSFv0uMFjOx2OiEOz8NjcLme5hzE+yldTHyUXE
 LWXw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848749; x=1786453549;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vFm+T/ETcyWAsma3YKUeTaFPeTTqZh6jakUluhChy/Q=;
 b=JxA0lMsXBMfGdxBLOxzNwyik2w0TBfElGnfvfT0XWaeRzKgCRP+erP9K2TWIYgczg+
 88vvd/fAmEOmxtfXatKkBH8PWDT2gyNdvncG/hA3uG/M5HDDkrltY/M1EgPFjOAfSuyt
 of3nUi/vI6rREoByRrE3ANte5/Ayws7aM+u6gqg9AgMft6dqsLKeOWVIjIlrtFsDFb9i
 NnkG3TwQWn0y9OlREH5PIkUaniU0uUGuddqh827rpec9meBLBx25Z6OtZdT3l0we9N7h
 OghrUGTVtdLgPf36IbX7CiIa4omHsTJ1nAccsGPlH5N5HYD5xY+hwbKKDVs/Lgp+/NHR
 fpyg==
X-Gm-Message-State: AOJu0YzSZ1u4dUlmvZaqwC2vaMXAnD0ghFIAkz+I4Ap5KblogtW5srDn
 SROBgM9PkzMKroDYJ3PMHCCFrZkalTItK7P6d/WBQs7ObpHpjmjepAGLVElcQpBGt6Io1YIt2oR
 MWkDvJ2boBQaDuL/XYcc719wGTLGO7HBJHY/306nd
X-Gm-Gg: AR+sD13gT34PnoK2WFzeAa5g1d/31XqzRumEI7Un0aU7O5i51YpGiSubq29Lfk0MBKt
 Xn1x5k8FwewLb6MpNlsA9OTnPks8RDnKWyguCU5Elf+ifHKz8djGnNQPbvhwwBLEY779NtzOWz7
 fUPoWpwagN8lyopG5Y8yjca7MzJqitw2J94wdQIVv1FEsJvu/R2+/LTBQWZCEhpwgyoUF2rG3BK
 f8KFwnVsxQCjuvddC5HitwVsn4ktW2TNUyVTOwvjh21BWWBrmoVNQroeaCUFLS+lys0RqnFL4V3
 crKJCBWTyAOCtOOvGYn+SG67GYqJIwolPKakbqOtsVmXNraaAhKVHQ==
X-Received: by 2002:a05:6402:2485:b0:6a1:2863:ad84 with SMTP id
 4fb4d7f45d1cf-6a12863b043mr3114295a12.11.1785848749403; Tue, 04 Aug 2026
 06:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-2-a3f1f16b53ae@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:05:33 -0600
X-Gm-Features: AUfX_mzMJVguk8HBEn0ucdc0aUHwRHtwpMCKi947Y1Hp_J_smLhJZxENCmM-d6k
Message-ID: <CAFLszTjn+pNik+Vc5WKeTBpz4vAZ39pFRfnGOYtLEjdA9vpjLg@mail.gmail.com>
Subject: Re: [PATCH 2/6] disk: part_efi: Add missing endianness conversions
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848749; x=1786453549;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vFm+T/ETcyWAsma3YKUeTaFPeTTqZh6jakUluhChy/Q=;
 b=OeNz6irszjf+AMAqBgjMhGwgAb9nYf5D+WDwt3tFXaeWOGg+3J5VszZ7wXomGYoiH9
 P7cbynPCcPlV2jA5s+e3GdwqCX3xncOylWtKc1B30+pUA0ad+3dr0wQL/nfYKr6/WWk3
 DRl4gJ1LE2qZ8O+NenmljBQwkupcQWV6c8Meg=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=OeNz6irs
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-31T12:39:59, Alexey Charkov <alchark@flipper.net> wrote:
> disk: part_efi: Add missing endianness conversions
>
> Several GPT header fields are read without converting from
> little-endian, which is wrong on big-endian hosts.
>
> gpt_fill_pte() takes my_lba and partition_entry_lba raw when working out
> the region a partition must not overlap, so on a big-endian host both
> bounds are byte-swapped garbage and the overlap check does not do
> anything useful.
>
> gpt_verify_partitions() compares the loop counter against
> num_partition_entries raw, so its "More partitions than allowed!" guard
> never triggers.
>
> It also swaps gpt_part_size, which is already in host order, having been
> computed from two le64_to_cpu() results a few lines above. Drop the
> conversion rather than adding one.
>
> All of this is a no-op on little-endian targets.
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> disk/part_efi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
