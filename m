Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33151D2F000
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 12:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A1E984013;
	Tue, 27 Jan 2026 13:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JTlQsGjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D910D8401A; Tue, 27 Jan 2026 13:28:34 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 364FE83FE9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 13:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f0l7L1hV1z9vMH;
 Tue, 27 Jan 2026 13:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769516910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwfBXZjbXeJPbCTdRc8QE7mgxSOQD2G+v7cIpF5tQNw=;
 b=JTlQsGjvzo8RO2QyUrEo3ewvm4GLnM4Se67KBXRfKCRoADWbfn3xtXlz+HwMZJ4BAtVQzf
 cO1xEqujW30wbUoiLSnLadVcqa5OME5HV+lifJbTFAZPmXKe+SfM2brTgPvLy5i2XWN/u2
 GlxWCs691SP+5aFjAU/1u6LfcM13v5bte/NRVZ3tJr5eufAyVnF0edfO0ky70Nw+Uk5rmj
 22cM+96RtlEegqeUrEEOr+tV6mruQKipRMBwUKWCpuzo6oFbe0+aHR7r/xGb7SLl2n3p3H
 OEDk5hNc64qo/6BfYIekPIVIlE64UHi0mo/ZV+t2nu/T185wFj9sfHCPd4EA0Q==
Message-ID: <a08810a8-e8fc-4aa7-aa36-11b5f0725aaf@mailbox.org>
Date: Tue, 27 Jan 2026 13:28:26 +0100
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
 <e3100b4b-98e6-4a08-aa26-df9dcceac235@mailbox.org>
 <956d86e5-6bef-47b3-a436-9acd03b38aec@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <956d86e5-6bef-47b3-a436-9acd03b38aec@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5ex4ksdpxh4hyqybx8tm1o1eq469gsns
X-MBO-RS-ID: 2d97b5e85dad3166906
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

On 1/27/26 11:22 AM, Neil Armstrong wrote:
> On 1/26/26 19:13, Marek Vasut wrote:
>> On 1/5/26 4:20 PM, Neil Armstrong wrote:
>>
>> Hello Neil,
>>
>>>> @@ -244,9 +275,7 @@ static void ufs_renesas_pre_init(struct ufs_hba 
>>>> *hba)
>>>>       ufs_renesas_indirect_poll(hba, 7, 0x41, 0, BIT(7));
>>>>       /* end of phy setup */
>>>> -    ufs_renesas_write(hba, 0xf0, 0);
>>>> -    ufs_renesas_write(hba, 0xd0, 0x00000d00);
>>>> -    ufs_renesas_write(hba, 0xd4, timer_val);
>>>> +    ufs_renesas_init_enable_timer(hba, timer_val);
>>>>   }
>>>>   static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,
>>>
>>> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Do you plan to pick this series, or shall I take it via sh tree ?
> 
> Yes please
Applied all to sh/master, thanks.
