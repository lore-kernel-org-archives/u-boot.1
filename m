Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284F3D19502
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 18:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88F1283BD2;
	Mon, 26 Jan 2026 19:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h/feuOlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3D9E83CEE; Mon, 26 Jan 2026 19:13:11 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8772483B27
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 19:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f0GqR3sW9z9sWq;
 Mon, 26 Jan 2026 19:13:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769451187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OjwucHTklR50jRcZIlWTkRjS1XV9Mg0XuEiC62AieGE=;
 b=h/feuOlTxiOcJ2s4F2UEGCNCT42qheZ5b7jR4fOlSPcrvVMQUNQgvscCrltmqWlagQOaex
 6M07Yi7SGC1CjwI982YRHa+/64lwZTtcJbFvwEkrtm7AGoQ+Ekqwb+TUxQLmDQwQzPpB81
 qnahXM1EX2mnXua5GOx0aXF4NVUVj9P1S3IsCjn+CnM1fDa4yzocdwDmo3Vq/BY4JAIRQi
 1+BySbvt2YjlOk7hrTqdilVInlIlLxkqvCap8pfexZbyfIzRXCq8qGNV3rL3pBBD6JIazR
 hssTLEpT67wMrVKPPuWXZ6XnxzuTXuk3D1TP4x0ZX4Ts41Mfm5T4H75OtBhYUA==
Message-ID: <e3100b4b-98e6-4a08-aa26-df9dcceac235@mailbox.org>
Date: Mon, 26 Jan 2026 19:13:04 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] scsi: ufs: renesas: Add reusable functions
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
 <20260103002254.183357-5-marek.vasut+renesas@mailbox.org>
 <a99b6773-5bd4-4030-9308-59db9d4d0fbc@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <a99b6773-5bd4-4030-9308-59db9d4d0fbc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a3jstc8byo6yk79g8zhpuigi7r848pcb
X-MBO-RS-ID: 2275b3952d64975a0f0
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

On 1/5/26 4:20 PM, Neil Armstrong wrote:

Hello Neil,

>> @@ -244,9 +275,7 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>>       ufs_renesas_indirect_poll(hba, 7, 0x41, 0, BIT(7));
>>       /* end of phy setup */
>> -    ufs_renesas_write(hba, 0xf0, 0);
>> -    ufs_renesas_write(hba, 0xd0, 0x00000d00);
>> -    ufs_renesas_write(hba, 0xd4, timer_val);
>> +    ufs_renesas_init_enable_timer(hba, timer_val);
>>   }
>>   static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Do you plan to pick this series, or shall I take it via sh tree ?

Thank you !
