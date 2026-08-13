Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FB9C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 17:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57DAB81334;
	Thu, 13 Aug 2026 17:59:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-uT0RIkCjuN; Thu, 13 Aug 2026 17:59:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D48FE8133B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786643976;
	bh=m928+qgJ6iaOFtJhWlpp7Pb3q8ThqlNgbpeLh4XiAd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f/IK0rd1dYlKoIRIQb8Z5LQhnZm90E6BteM1AMYQTnzTahTubgx6n2f5jLB9IGaai
	 /HbffG8kT09JqoWG3PcYj8pnUs9fSoGpHGo7OK+wJvTaEGACCWBdTmNlDYf7l70q2/
	 Lpq0UPqoIYkaN9A0DOpCRFWXjrWO1jhwtm+Vdv9G4o1bstl8iSCGyuQCHlF/+0YEeq
	 zl/pCa6LK2Z7eovOxp7YKEX+Z36EY4pBGhNsXN9K96MBTDAeABR213yFor48jh+RVH
	 blT2llzJ4k8wVMuB6pQztL6A6FKpkkwHwOiTtVhBonqJh7xsWPRA/p7Yf8mZhAwPC/
	 hdYcg4Ex/MFVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D48FE8133B;
	Thu, 13 Aug 2026 17:59:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E5F583A4
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3F2740158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LFkmyw3A9nq8 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 16:41:21 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C356D40168
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C356D40168
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C356D40168
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 16:41:20 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so1154725e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 09:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786639279; x=1787244079;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m928+qgJ6iaOFtJhWlpp7Pb3q8ThqlNgbpeLh4XiAd8=;
 b=DsJZSUirrew3jrIIz6paeveJB/ZX6eqWhddpI3DnErm2Tmov3KePmGWfUio1kE8DxL
 reuTf8YzH0gXKZBRWon020h9ZTPRfdjpkQaCxsrog+QVILat+9sSIKoHe3alVcg+rld8
 n298kftj9vpOC1ecuRXFHDcJ0JSGpn+oZXJjjv5SOnwzSlTZDsSQ+F+H0khCvI7iicK9
 7eaHXbr7yULrlz56E2jgTGEfVD6F4qVLbjgXPNWK1dmaOt6AuwW6tPxLSnCLOHL6iaba
 nYrdUakD+TjUppQhfUDdf7WD5IFAWxNzoPwgaRWxFWASFdQ4o8330yqqGzZHQ1/kzhXl
 DG2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJdJ2nSVGOqaDvIW2KZACr7115VEFnDZrrFTPNq79AcIYtmakxxh6NsxQlqkmJ+Gb2hx0tE34=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yxqgk+XRwz6ml3k9yR67XKG2mIuk+lCjfh9/Qb9bVi4OcejQCP0
 tgibchjUGo8gZUY+vUxrKDvlrqEQkeamUSqHiQ1zajiu69FMQ/Cn+UOozTjHWGZL1ls=
X-Gm-Gg: AR+sD131zk75+WkFTSLwu0PRgAR8nUIPsdaUJmuj2W67CsTLA8VMBTOOTuNuWzcrtx8
 I8ENQynzV0knN1pfEhnEitxYQWB4ErRwfukPdybXsg1rMtbfra9EmSOEshX+e6YAOPHs8sU+/LD
 7/0gPCUYYLip+jM9Cl/JiCei2AUnYA7ftFmRMoqzHKtQf1wKmfjI6pLRLAEUnx/oqrH9hW7qfJ0
 HLXdifMDLAUap8ZOdK8uVIset6ay+e8vm+7iFGPkCVJm0sXWr8wqU078siVUrR0VzPUUYH+8LOt
 zZOWQnNF28KMX0RMcgwJ/h347TWYu936zgBtn9bHG+Mu12rUzqSeyso+E20H+juPSRTmENaB+Gq
 68AXvtpVJ8C0mYASnlUCkFY7CzdFR0lyst6PjaxrwGuGzH5p4fRJ4DCT5EI2Z+G08P5PDJKOV/O
 InO0pFdfZU5aS53sUe+B308NVjVtVdweOwSjdN2rD3XdtE6UQF8oJeZeGconV42/K+x99S0spRo
 FIjTcm+G9zcyVTAm4SUqDIkw5mKqX2yIS8c0YctijdN0+mtN8psq5yQOxoAvLL5GTMhhfBT4L1y
 p7XsK9HDDPYrhziV+WI7as/AVw4E4nR9AQCmuGKxKPUv
X-Received: by 2002:a05:600c:8283:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-499821cb307mr97574485e9.12.1786639278705; 
 Thu, 13 Aug 2026 09:41:18 -0700 (PDT)
Received: from ?IPV6:2003:ff:f03:8f00:b111:828d:2817:5c05?
 (p200300ff0f038f00b111828d28175c05.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b111:828d:2817:5c05])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49982130365sm81131985e9.7.2026.08.13.09.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 09:41:18 -0700 (PDT)
Message-ID: <395519c3-fd57-4329-9a61-0a9df524cf75@byteray.co.uk>
Date: Thu, 13 Aug 2026 18:41:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] test: dm: nfs: add a regression test for an oversized
 NFS read length
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260811-nfs-oob-fix-v1-0-5444d86d28d7@byteray.co.uk>
 <20260811-nfs-oob-fix-v1-2-5444d86d28d7@byteray.co.uk>
 <ce8b5c8e-d62e-4e28-bab8-dab2d26a70aa@arm.com>
 <f70400e0-9444-4ee4-b7ff-dea8f32d6c86@byteray.co.uk>
 <bed7313e-fd9d-40ca-8f27-72733b65ba2b@cherry.de>
Content-Language: en-US
From: shj <shahriyar@byteray.co.uk>
In-Reply-To: <bed7313e-fd9d-40ca-8f27-72733b65ba2b@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 13 Aug 2026 17:59:28 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786639279; x=1787244079;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m928+qgJ6iaOFtJhWlpp7Pb3q8ThqlNgbpeLh4XiAd8=;
 b=PTAUQ/ONj0zQ6vESt+zTQAhcjEBMo14NkT8wB9YHrjc0KqRuZ3pxrLZM0ZsImesm6G
 A7hGtX+swltnJPEHojtRAlWFxV286ASJGy+jaee1uO48KcMLGCSu7n5Dl00YgHlOQddb
 OvDGGJzNP5AEx/OE2KDEuOqDQ3MOWHlWBLF2mDXaBfr0VNE+J0VagAYYwYNZKShY4YB9
 VMro/dRsFAiusW8ZLa/1m8ujpiZWkTgrEp2laxv/W7suksFXCgAeAHvarnigJcvFVVOs
 OieAjU4t2V2yO/A9i3eEV4m4/2sAlYzIjfZSABC9zVCEI5WrKEr0VSMFGbdhmEaqwHTB
 hHlQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=PTAUQ/ON
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

Hi Quentin, Jerome,

On 13.08.26 18:11, Quentin Schulz wrote:
>
>
> On 8/13/26 5:42 PM, shj wrote:
>> Hi Jerome,
>>
>> On 12.08.26 17:06, Jerome Forissier wrote:
>>>> With the series applied to for-main I got a CI error, see:
>>>> https://eur02.safelinks.protection.outlook.com/? 
>>>> url=https%3A%2F%2Fgit.u-boot-project.org%2Fu-boot%2Fcustodians%2Fu- 
>>>> boot-net%2F- 
>>>> %2Fjobs%2F68484&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cfcf4355cfe314a023a7e08def9538abe%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639222334948504305%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C80000%7C%7C%7C&sdata=nNfbYn4Y0KW9fswuFVBAVh5ceKMSMFfACtCcOHpIdgw%3D&reserved=0
>>
>> I applied both NFS patches on top of current for-main and ran the 
>> sandbox tests (I forgot to enable CONFIG_CMD_NFS in the sandbox 
>> config in the previous nfs patch, and the nfs test is skipped, 
>> exactly as in your job, sending v2). But overall I can't reproduce a 
>> failure, the failing test in that job, dm_test_dhcp6_serverid_reject, 
>> isn't on for- main. I applied the serverid series (fix + test) 
>> verbatim on current for-main (b752e441790) and 
>> t_dm_dm_test_dhcp6_serverid_reject passed.
>>
>> Could you tell me which tree/commit you saw this on (the job checked 
>> out for-main at 37f4c339, which I can't find on for-main now), or 
>> point me at your merged test/dm/eth.c? I'll reproduce against exactly 
>> that.
>>
>
> https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/37f4c339a4b20e8b60370d6b0f73560c04feef7c 
>
>
>> Thanks,
>> Shah
>>
>
Thanks for the commit. I reproduced test failing on 37f4c339. On that 
tree the test "test: dm: eth: add DHCPv6 oversized option regression 
tests" is applied, but "net: dhcp6: bound received DUID option lengths" 
is not, so the assert trips. Cherry-picking that fix onto 37f4c339 
should makes the test pass

Thanks,
Shah

