Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D51C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 21:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13B0D869A1;
	Tue, 15 Aug 2023 23:40:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XbzM+j3t";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="chd+jYAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D8186852; Tue, 15 Aug 2023 23:40:22 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C5E8692F
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 23:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RQPnb4PzBz9slX;
 Tue, 15 Aug 2023 23:40:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692135619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FRtwPdyE/HIMzKgJjepXHnFauLdwU8KP+ADwWTLkcw=;
 b=XbzM+j3tQnU4fffhTL9eaiwyuhjHSgycis2Xn4FFONwPljIGS9D1/fqyn2cL9DeeD5hNbq
 5nZusEFj1i0IV/R9ku84GB+qyKfiLZXSV1/Ni/Vdcj45/TPAuhgzOfyYZTgnfX42fkHVmE
 Q7wBA88/wB1UyVCpDNOYREPywz/Z/Db+0WhZc8WV7GfEx4fCJs0k6bvl9U21QoxkyD993I
 X6TOKqMUbT6eU8CaYj5hbCOWRYp7dQUinWb7OPwcJygu4JPagMKGiMh7gOxeNAnVEhYRvX
 0U0q/C3OcpRcPFH+aLzIes+QFGuPXN+7TTTuQ4hcDXEkXHst50t0CCuOtKkxrg==
Message-ID: <4da6c1d3-dfb7-33c6-0887-e7ec3e049707@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692135616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FRtwPdyE/HIMzKgJjepXHnFauLdwU8KP+ADwWTLkcw=;
 b=chd+jYATRF4+508zMFAl3+VQBB6dVX7DATOMOWSEvcr6Xxv2bJ39mxB7WTJjMw1loUG0Mm
 GUe1ALD8z/IXiFwCsyte0Ob1wmC8Eo6VuCDROuplLrTBdTG0Od692DDLfeS8cFah+onIkH
 1faBZYasUVZQRzN+DAlA/G15RTcoTwCyVO09CHWaz2yFzO7D4LldqEobUfDk2zJA1DWyW6
 neZK8aigqwSkfDzuV3b3tS04J3FMwLt7xdYORbvftWLns9zP7AYt3WBBKSti2ZUdquy1Zl
 ZbRWsm4AVE7313EStfXDlJqPfTOOp4HK47oa/OuD3uQa57tEJqAvn3X8pxSw2Q==
Date: Tue, 15 Aug 2023 23:37:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 3/6] ufs: Handle UFS 3.0 controllers
Content-Language: en-US
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Faiz Abbas <faiz_abbas@ti.com>
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <20230813235231.591454-3-marek.vasut+renesas@mailbox.org>
 <CAH=2NtyeiRyN1pwJ8ukXXbMiD6Yv2bUgYdoVkd4D4mM2f3Dw_g@mail.gmail.com>
 <2f97ee68-65e4-fcf2-773e-411936c8227d@mailbox.org>
 <CAH=2NtwTWud_8iNoMgWmOPYVoHTXEZAgcsr4Gmv9fq0SO2tfYg@mail.gmail.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAH=2NtwTWud_8iNoMgWmOPYVoHTXEZAgcsr4Gmv9fq0SO2tfYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 17a49fd370b410b7124
X-MBO-RS-META: 47pxd81gsf9k44tcpyechwhduk77t1cf
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

On 8/15/23 23:05, Bhupesh Sharma wrote:
> On Wed, 16 Aug 2023 at 02:31, Marek Vasut <marek.vasut@mailbox.org> wrote:
>>
>> On 8/15/23 19:14, Bhupesh Sharma wrote:
>>> On Mon, 14 Aug 2023 at 05:23, Marek Vasut
>>> <marek.vasut+renesas@mailbox.org> wrote:
>>>>
>>>> Extend the version check to handle UFS 3.0 controllers as well.
>>>> Tested on R-Car S4 UFS 3.0 controller.
>>>>
>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>> ---
>>>> Cc: Faiz Abbas <faiz_abbas@ti.com>
>>>> ---
>>>>    drivers/ufs/ufs.c | 3 ++-
>>>>    drivers/ufs/ufs.h | 1 +
>>>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
>>>> index 261ae2843c2..58830c8ddca 100644
>>>> --- a/drivers/ufs/ufs.c
>>>> +++ b/drivers/ufs/ufs.c
>>>> @@ -1903,7 +1903,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
>>>>           if (hba->version != UFSHCI_VERSION_10 &&
>>>>               hba->version != UFSHCI_VERSION_11 &&
>>>>               hba->version != UFSHCI_VERSION_20 &&
>>>> -           hba->version != UFSHCI_VERSION_21)
>>>> +           hba->version != UFSHCI_VERSION_21 &&
>>>> +           hba->version != UFSHCI_VERSION_30)
>>>>                   dev_err(hba->dev, "invalid UFS version 0x%x\n",
>>>>                           hba->version);
>>>>
>>>> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
>>>> index 33ca5f29812..ef7728fc39e 100644
>>>> --- a/drivers/ufs/ufs.h
>>>> +++ b/drivers/ufs/ufs.h
>>>> @@ -781,6 +781,7 @@ enum {
>>>>           UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
>>>>           UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
>>>>           UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
>>>> +       UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
>>>>    };
>>>>
>>>>    /* Interrupt disable masks */
>>>> --
>>>> 2.40.1
>>>
>>> SInce the Qualcomm UFS HC controllers are even newer / greater version
>>> values, we can drop this patch in favour of my UFS patch here:
>>> https://lists.denx.de/pipermail/u-boot/2023-August/527215.html
>>
>> Why not keep validating the version ?
> 
> How many versions would one want to validate when the newer versions
> are 4.1 or greater?

I'd say the ones which are known and tested.
