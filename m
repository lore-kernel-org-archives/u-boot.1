Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0E3CA0FE9
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 09:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C02E882FC7;
	Tue, 26 Aug 2025 11:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hN4d1TuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEBDA83071; Tue, 26 Aug 2025 11:07:54 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A91EB8003E
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 11:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q31JQ8026983
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 09:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6QhGSdXxeVOrTIUwWMSTkvpeFINJCIk+ZX9kgQ58pBI=; b=hN4d1TuFIE7+qeRW
 L6Dr0eYR9RfFhfwutp7wvJw9eBka/E9GSJ/oE+PmP1SIx1Rzk7BkjV334pzp0adX
 1PuByUkMbgNFd1OPBxDvdjCUA9tQDSpya4G2S2g1y36MziQmaRr9DKwHuYRAFEKQ
 Ev25gi9S49+2FVc1CM5F/IxbA8eKMpx5ecEUHFOzJkWnII2J5gz1RPcVT8YvjZkK
 yMh9X1/OaG837GK+05Bio2vizFmFwf027BaOpPzWHAktsYifrakdJ5pL//F3eGgs
 lHksGs1UzBWIvJJohPJzGwyz9adAH4cLLwQk1WPeWKqJvjjXf3ZkDN/odPmHNsOE
 iBEVKA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q6x887u6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 09:07:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b49de53348aso1514718a12.1
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 02:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756199270; x=1756804070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6QhGSdXxeVOrTIUwWMSTkvpeFINJCIk+ZX9kgQ58pBI=;
 b=kH0+fC4LhF/Ns5qNSw1QY+KY1Zf5pp9ePENpvHNIartlDpVYyxChqUMPmrM8jmbmZj
 YpeyhLq4jv+ScY7Iyob2Xgbpv/dmgtckid3UraxtQvBp2zrJS7/z5LebDgTYe4SogW/i
 +CvodEaVCTtKrpkxIGjFamxrRDMRAvSyK+fzWhmSLDPtS8FMqnm56RKOLFarz7r8lq8N
 yeT2Ag0OPQcTZ0l7xdPAxMp3CqGFUTu8LPsJKtS4RV9Nv6FblkUgUGvfhJUyFj6mRpxt
 q7iwW50ofeSP+vc0gRn08OsPZcvlwCZiJgI8XnCrMwy70ce3XMsIB6zgzTXFX/T/UdUB
 LC/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCYPWNkiyw6uqmVTNtbNNiF1+djLWBfWoLVIdJiHMHrpuk9cCpinjzlzFam9wRAYfEJl0UMiI=@lists.denx.de
X-Gm-Message-State: AOJu0YyEfvXCaqwf6IbaT6g19kfizykVHqiXH/8KsRkXpb/lEGSPScm8
 aYrQqtIasN+n+iD/QQMySiiRBxCAdhrvut0zV3l7it2hXoCi/jHJTGeCO7zzwhCbL0RVLwSY+8g
 V+EugSjmAIXaSEV0fuj1YSNsMWRH15FtOHkb/RjOzaEMiNoEC9B98h8Dk
X-Gm-Gg: ASbGncteEkTEX0SdQ6TR9THI+celFjdwbI9LcnteUKfN/iDRKS7xka3uv5ChRuYYb8S
 vgE9UMSHCi+6u0AjdLZ73GNuOoUMCT6TVLBGO68tXfcIZvgKjHtj21x+yl+lscWJekpb01HwW5U
 7w91cgzUYEx+VmxvCXdhmKSrWRm0u9Yy3x4TM1yuGBfMD6TKEJhDZUQz0H/784o6HNJDasXmH2c
 ZozDQCT5bhgRyFnI725fVEbhZHgsCXzxvJrDOkSRHbW6kYhZDXjIftFMaSDsePL+b5sJdVDl2DH
 ixLtA0jKl0OHj24MG6fgeXD3uWtwP5SerqM3oXl2jVnmoM726CDdH4GoUDrZ1Ek1I39il9WJlAH
 a
X-Received: by 2002:a05:6a21:999d:b0:23f:ff4e:fcb0 with SMTP id
 adf61e73a8af0-2438fad26cdmr1525244637.2.1756199269950; 
 Tue, 26 Aug 2025 02:07:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYNvEIW1qN5RrX6Zugz49C0hZNTq54EbkHKbb201UlPFRKDqeR1GVYrnGyD/dJ/h8198fvig==
X-Received: by 2002:a05:6a21:999d:b0:23f:ff4e:fcb0 with SMTP id
 adf61e73a8af0-2438fad26cdmr1525186637.2.1756199269426; 
 Tue, 26 Aug 2025 02:07:49 -0700 (PDT)
Received: from [10.151.40.76] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8af649sm8475852a12.22.2025.08.26.02.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 02:07:49 -0700 (PDT)
Message-ID: <8730e084-5541-4df5-b067-c97e540b5f37@oss.qualcomm.com>
Date: Tue, 26 Aug 2025 14:37:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] efi_loader: improve device path matching for
 partition lookup
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, xypron.glpk@gmx.de, adrianox@gmail.com,
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
 <CAC_iWjK5d7z-J=rbXa-_+2zjejWOuTJco87-yqJVXtuXmVjdNw@mail.gmail.com>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <CAC_iWjK5d7z-J=rbXa-_+2zjejWOuTJco87-yqJVXtuXmVjdNw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ODudB011SRDu96hoSAhRpwF3j8PZHBfN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDA0NCBTYWx0ZWRfX0qjFpZ2Rxiju
 EDWS1/aQqxoxNSZHdhIpvCjjaB71A29IiqP2XkqnYmVnad/otx7WEicGv6MiH04DVhx+asKwDag
 dE3UzK2CwJImUkxk7poRn47VuGpqSv2N6nki5bJ2V3fg0TqGRiT+H0VxRTFc7o1pOwLpodFM3KP
 hklrfpiNpYHGKD0HIUEb1yGURBfTXG+blxX7jQJ+y4XZf9xfeyo982DcLKeoV2EHNjV5EiSTu8o
 lkiGhedsTq5QlH14sM3SERp6hzoJarIPAmzcaiwqofh0bOfeZ/zUw2WuhK/ZwsVEvdHl5a162aG
 W+lGHfK6zTOslyZGB1SWFarNgQz1HihbtykGuokJjpFTtVIznH7u8So8WvCIfkQwaHCaYB0Ksfx
 3x6sCB76
X-Proofpoint-GUID: ODudB011SRDu96hoSAhRpwF3j8PZHBfN
X-Authority-Analysis: v=2.4 cv=Ep/SrTcA c=1 sm=1 tr=0 ts=68ad7966 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=cfdTzeN2tWeyBRAf8O0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230044
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

Hi Ilias,

   Sorry for the late reply.
   If i point to esp, then it should work.
   But in the boot option generation, they are skipping if its a partition:
             i.e., in lib/efi_loader/efi_bootmgr.c: 
efi_bootmgr_enumerate_boot_options(), in this code (line 838):
                 if (blkio->media->logical_partition)
                         continue;
   It seems that, by default, the boot option generation logic is not 
designed to include partition as a boot option; Not sure if this is 
intentional. If its not, then should we correct this logic? Your inputs 
are appreciated.

On 8/5/2025 1:17 PM, Ilias Apalodimas wrote:
> I am not sure this is a bug. The EFI spec says that in order to
> trigger a capsule update you need to have an active boot option
> pointing to the same ESP the capsule is installed.
> Is your boot0000 automatically generated? If so it doesnt point to the
> ESP and the capsule update doesn't trigger correctly. Does it work if
> you manually add a boot option pointing to the ESP?
