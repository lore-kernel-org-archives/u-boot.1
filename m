Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF1606D83B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YxVCgmYl;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Bq/sJf1x
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FAB76070D;
	Tue,  3 Nov 2026 08:36:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uCCtqALiDAvb; Tue,  3 Nov 2026 08:36:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 244E5606FD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793695006;
	b=CDBjf6UB+CX/7XXoC/oOfXMSb4xCcZCHtKD0gk8HFBz3Ek0IB866WxYoQkenZM7lDbQ/
	 8fEfwki6NDO2eeKU5ySvbXGljQEYIwERQ0B3ATE9zied188oZrxUPO79FAqBgSgKQhaVF
	 dYb4VrDb+0vGCzreG2ShRLuxcZNGWY/sJPkMSJGpwrcAPHLInEFBRVVWChZ/T7+aH3z8R
	 16bPUpx5r7szlu+MrQcukX/WJWlIiwY36fO15QP1pCf2qbQzrofjkSwpyBNhV++8DzPLq
	 qigtNYbjLKttY7ggDOMRd5wbAjuWdTmpbTcEJo1ZE/DeIvhM2boe5PFc6gLBTst+bGA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793695006;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZNAb/YbKq2GrVZUwl7u1MftB7225XsNuSHZsJCKh2uY=;
	b=ql0qYIxe4nDertK/SCexso6MSRqari1tqG/YGJ6OBdChibqS77nSwvPrqYCW2ufZcQKz
	 xYsHq3MEwm8urOhUe/tceNSZJ94VjtRx4E5ZW5uOzbtZEvlcSrXXxyl9BZOjOB+IHwWfK
	 nLcC/2c9bKl59NLmSOrbbhJylma13Es1BNTBziUTB/G6K/CNs7joEsqOvXkCeaS9rc/Ac
	 Qcwmi6eD4MB/IqI6eirhYdzkogo3DVjDlIgP2iArmtniXj5k61Pp8XsOXzwAsxO5TNI+j
	 t20Nczt9zIpmZljYO12KKIHq9VjG/ih+X8Y1fBhSnCrGzyMn7eDbVRDXtVYnIAjbD6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793695006;
	bh=ZNAb/YbKq2GrVZUwl7u1MftB7225XsNuSHZsJCKh2uY=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YxVCgmYlak6W7ppbsoroVv3amdbhdufuEi3FtL6fg/8D4Q3MOufbg8b7L0SDJ6p+C
	 fzfJRz6uYApJ9e8tUK03kO65e2SbF/y7xkd7i78fAGGOt67xfPvB+sMM3GmNhZr+J3
	 m+slFIFpHi/Mdakeny2D3nsZDrWDxPnSejgAtM0MAUl0XP8aroPHig3S5QXuoKi35Q
	 m25TQGazHB96XT4J6hLYDP1Ebg7dJghQ7UMADBnPB1nf6/aMyWzVtBsQE4szgCMbW+
	 +bY4PiDs3Zwa4YdjIJGoukoGmWwZbU85xEkVCwdMRonWCoZUao2uZaP/KIQaj6kdAo
	 crg272xBs/RmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 244E5606FD;
	Tue,  3 Nov 2026 08:36:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A096356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:36:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 273E780E04
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:36:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RJtQRLUQ2bAa for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 08:36:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4C3280E01
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793695004;
 b=ImoORPwv0xe9UnQcH4WEM2BC5vv6ogu5hQnE6imBpxL4M/ei4i7hGQ0c7XXbaAKVQ030
 erfBM3WDYlnZw9zNhc+Y1gk88dqtuF4sq2PXo6ZzLMBW/eUk2LEHQ5fLaxUpcFP/pOImh
 3IrvGo7P4MqV4vcdcCAIlOR6eMojCUMBKdhuknzo0TLlHDnM/RK1K7jKYETon9H+iTMUR
 SpqWswAAjEQ6CX+LfASUVGH44NRaI5Z9NN/m6mI0Fq6GEiEHbOBB0/cSqSw4vIRCPCZz0
 iarzokqcWKyks2uYt47xaAg3ydxaxj45yqFeZeO8KPzXYSJU+WtKWwNxS4M/BDCC+3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793695004;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:Cc:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=ZNAb/YbKq2GrVZUwl7u1MftB7225XsNuSHZsJCKh2uY=;
 b=k/AXwDlvCJxafI+h3M2cpp3koZhTWYzMbT1cvXXk4NXfmrP6UO+dfDXLayiNDCkzxy0b
 S9hHQXeLP3u2uiTufzL3QyaZVAXZ5HAxciVHHlRXH2GMqWW9Ije5icNzSR89twoIgs6oZ
 vL7ySdP4Adm/wE5mt5r3EJrb2yElPROFYYstpNHibdVbALYiB0OVmlKPYsJGzPB62T7GM
 z23brlhlmfMdC4TE+yIHjv+XwoQuk/4nLYd7RWexvITZZjrePeFj/ZXyhqj8D2xhdR66L
 W18XXGPF00GFBqtUyq5E80/Xii542cZNh41SjIvSNOOMbCHzx3omQ8Hd0VCIplqZ7kQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b="Bq/sJf1x"; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Bq/sJf1x
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4C3280E01
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:36:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9B3541098E9; Tue, 03 Nov 2026 09:36:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793694996;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ZNAb/YbKq2GrVZUwl7u1MftB7225XsNuSHZsJCKh2uY=;
 b=Bq/sJf1xXLgNR781rDcfUlUvk32kDyfFSHCjmGd69iU72tfzidH2tqkoLrD9QyVwyMWJE3
 ma008oOC6zkr5Plir2NmaSY+rx67ZipfG56Mwi65+8wvcGk5ITuGmtUpcCmsxngIsR8EUR
 5Pi0NaUoX6csuoNVJmmjx0Tr6qcJO20RcY69xvKGCE6dh9gzPEVo4hRhidZQ/XqxsSWRWu
 qqrwAo6bsVNqMI2+r7tI8EkbU/82EIyODJmtpW7uncmyDgidnHxgDlFsiPwnVgndmAyKtE
 E9/UD+NtpWGCyXjXgrdOxrRqKxVecijP9h6YDG9xIOP3BGtopaK8TooxvXOsbg==
Message-ID: <2b0f119c-b26b-b2b4-08e4-439245beb650@nabladev.com>
Date: Tue, 3 Nov 2026 09:36:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <brads@mainlining.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Cc: =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
 Mario Six <mario.six@gdsys.cc>, Peng Fan <peng.fan@oss.nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Sinan Akman <sinan@writeme.com>
References: <20261021160145.10430-1-brads@mainlining.org>
 <179305815837.10976.380221911015278933.b4-ty@mainlining.org>
 <7502C221-FFFA-47DC-B3AE-4269C4C6465F@mainlining.org>
 <d3b2f30c-d9c5-6566-5048-3e82f8c46ff1@nabladev.com>
 <811302be-3815-48de-b5c0-141be2ec3bd6@kernel.org>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v3 00/26] powerpc: drop unmaintained boards and SoCs, take
 over maintenance
In-Reply-To: <811302be-3815-48de-b5c0-141be2ec3bd6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christophe,

On 03.11.26 08:15, Christophe Leroy (CS GROUP) wrote:
> Hi Heiko,
> 
> Le 01/11/2026 à 07:18, Heiko Schocher a écrit :
>> [Vous ne recevez pas souvent de courriers de hs@nabladev.com. Découvrez pourquoi ceci est 
>> important à https://aka.ms/ LearnAboutSenderIdentification ]
>>
>> Hi Bradley,
>>
>> On 27.10.26 00:50, Bradley Morgan wrote:
>>> On 26 October 2026 23:47:58 GMT, Bradley Morgan <brads@mainlining.org>
>>> wrote:
>>>> On Wed, 21 Oct 2026 16:00:56 +0000, Bradley Morgan wrote:
>>>>> PowerPC in U-Boot has been orphaned since October 2022. Several boards
>>>>> and SoC targets in arch/powerpc appear to have had no active community
>>>>> maintenance or testing for some time.
>>>>>
>>>>> This series proposes removing the targets that are currently
>>>> unmaintained,
>>>>> to help reduce maintenance overhead and ease treewide work. If any board
>>>>> maintainers or users are still actively testing or relying on a specific
>>>>> board, those removals can easily be skipped.
>>>>>
>>>>> [...]
>>>>
>>>> Applied to next at u-boot-ppc, Thanks!
>>>>
>>>
>>> Pretty confusing, hmm? Sorry for the confusion, B4 stuff. Heh.
>>>
>>> So I would be more than gracious to rebase if anyone was to NAK any patch
>>> in this series, I'll wait about one more week then send the PR, maybe two.
>>> :)
>>
>> Thanks!
>>
>> Please give people time to react, as most of powerpc hardware is old, and main
>> business is not anymore powerpc...
>>
>> I can speak only for the socrates mpc85xx board and it is still in production use.
>> (Luckily not in this series!)
>>
>> I try to convince customer to give me some time for updating to mainline and may to
>> setup gitlab CI (I have a setup for this including a BDI2000 for recovering board,
>> but need some time to get it up and running... hope I get some).
>>
>> BTW: Do you have any powerpc hardware (as you volunteer for custodian of *all* powerpc?
>> I do not see much commits from your side in tree...
>>
>> Also, just finished work on mpc855 board (port to 2026.10, linux 6.18 and yocto wrynose)
> 
> Don't worry about this one, I'm still maintaining mpc8xx.

Thanks for your work!

> 
> Being a bit surprised however. You dropped 8xx support in 2017 without notice with commit 
> 5b8e76c35ec3 ("powerpc, 8xx: remove support for 8xx") and I had a hard time bringing it back.

Yes, sins of the old days...

Surprisingly customer needed just an update after such a long time to
newer u-boot...

> By the way I only partially brought 8xx back, only for last generation 8xx like 866 and 885 which 
> are the ones we have on our boards. See commit 907208c45299 ("powerpc: Partialy restore core of 
> mpc8xx") for details.
> 
> I don't think 855 is supported anymore, at least register PLPRCR comes into my mind.

I only activated PLPCR with CONFIG_SYS_PLPRCR Kconfig symbol... and added also support
for serial console on SCC1, FEC and flash worked out of the box.

It is currently WIP and hope to finish soon, waiting for a hardware update, as RAM needs
an update...

bye,
Heiko
> 
> Christophe
> 

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
