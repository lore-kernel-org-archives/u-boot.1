Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDE3C87FCA
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 04:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6129982CBB;
	Tue, 29 Jul 2025 06:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LdTQJOMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 288A282CFA; Tue, 29 Jul 2025 06:30:30 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B985C82C65
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 06:30:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SM3wYu005231
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 04:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uyZkHyLoYMns8FUcvFDoERvxTnS/9LEh60Xsxy0vTX8=; b=LdTQJOMRzwYWRTBj
 EU3isym1XQIV/rweaWRYvP5vPsSmVF6RyUA+lPQ3N0vz2M4aF59A3NHPc7G3rkz0
 DN4Qn2MNc/6VbbKKUt5tnEi0CUdW0MqukwfPNJBIt2yEJ4rME09iRDnZ8esrw5dF
 wIf1iDuwtkk/uL/cHBk4iiwxNlnGahP63mPHhpgkP1Kk9GTbml8Vo7I3LA2KKaIx
 lf7VJHoHNwmYpJknP8j0v6J0PoHvh1ME+T5ODyusG6eNQkPqM/EJMay1TYwdz0XV
 6D1vY0wG5/nmsjiaG/7x79ijlFp1FSLKYs//aWm65h7QZX9+DE8EvoIvBdzsSKOx
 sAA5vg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nytxy6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 04:30:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31f2dd30823so797753a91.0
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 21:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753763424; x=1754368224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uyZkHyLoYMns8FUcvFDoERvxTnS/9LEh60Xsxy0vTX8=;
 b=p1F9s/RnHiulR3UHO5j+n9CRqx+HzxIAGAOFAIf7F7RxN7y+GGc04mQ3Vb08QVoNgA
 F134g14otKhBQ7kzYX+TZwYVimpyM3zVoyaZQ0T/kqgOEOG8jOAMwRWjglBHgK+UbgW1
 MahHlr6mPqPDJWIkf8zIDiR1d4JcM1lHPjqyxPdvGpbUADPNzSCnjA4h3x4In3ReSTN8
 SBQm0zm1aLHQambxEtfwXsJjAxizmVnj7X8rsz/llvu39ZykdFQetzStjz5bv2w4Xdz+
 zqXW6Y0dsLgOovEtWd8jxBOpz+EFulBn6jfPzrwhO8fy1bukB9BczKcWALaY2vZ22Vnf
 bqHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEYLNsxcVet/XJXRuwsrnK3t9SNDCae3/422IaZ8se8RzVeqUm9tPPpfJ5vFx44cklclxJhkQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwrOwgch7wCit4phcfITwBr+15O3yKF6tebaX2RKb9EljBkzVD0
 kOOqUTvybUsYZe7eQWmCCxCC9YZfCilKeU+iDY8Cy4jl0Yb7XxL0rRiNnV+pOE9E+VMsUjMkEQ/
 m7F+Cx2dG2Pwq/58Zkuf9OVsB580MMYIhvEvO6oKvekWGbMHRopRdGgmF8vZzhwkL
X-Gm-Gg: ASbGncvxvqUQ9s8tu0Hue68I1dywqAI2BoFbziz6I/o9D9Q3EM7srQ3YH7A33aQ9bJH
 OYJVEmJpqH9HOvbXQgOY8Yu/rDCe/1pYT82u85H3eLM3abGzqlOzhfrNAxvaiWFVUCzmnmqkscP
 x5X+4zJ5AVjib0Y2yL0BLfGHEr5fqEUufvE0ELM5Oww8A0bGzy/MJQ7HvIJeuVlTxUnkKE4KIXQ
 2n2/7j4+Z0zL5wPgcIi32I6eiW08yQO+1PBeQwjbbvHMui+BF4rysk8JbC/EunicpX4/0vsVbLX
 zJ4RhkhtiJNpFckXsgmwOhWgxf3JpUpcpeiHHVUdZhG6abgcP1V62OwpJdC66E+Oz9vCYsv2
X-Received: by 2002:a17:90b:4f46:b0:31f:3c3:947c with SMTP id
 98e67ed59e1d1-31f03c395camr6748992a91.10.1753763424346; 
 Mon, 28 Jul 2025 21:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU3j+9GPBsvhD8gc8QumCH5vqwkLZ3S+A+M24Jzi6wf1HsVa2qhmqUX/RQ4XpPvG/H64sk2g==
X-Received: by 2002:a17:90b:4f46:b0:31f:3c3:947c with SMTP id
 98e67ed59e1d1-31f03c395camr6748941a91.10.1753763423744; 
 Mon, 28 Jul 2025 21:30:23 -0700 (PDT)
Received: from [10.151.41.95] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f328b9dfcsm413186a91.16.2025.07.28.21.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 21:30:23 -0700 (PDT)
Message-ID: <434bd963-2e86-42fa-843f-a49932b99a1b@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 10:00:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] efi_loader: improve device path matching for
 partition lookup
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, ilias.apalodimas@linaro.org, adrianox@gmail.com,
 moritzf@google.com, sjg@chromium.org, maks.mishinfz@gmail.com,
 javierm@redhat.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250724090009.569341-1-balaji.selvanathan@oss.qualcomm.com>
 <20250724090009.569341-2-balaji.selvanathan@oss.qualcomm.com>
 <0ccad71c-6fc8-4c10-b017-85f31f77c161@gmx.de>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <0ccad71c-6fc8-4c10-b017-85f31f77c161@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BRcO1ty5tthEXCAkLnJUWaWaU67XjpM_
X-Proofpoint-ORIG-GUID: BRcO1ty5tthEXCAkLnJUWaWaU67XjpM_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAyOCBTYWx0ZWRfX40i53zLYTJ4k
 chGx2IT+BaIs6yvxCQFoZh8JqG6YZvNmByslbM7a26SyRn8sdIszCFZfQZ4NoWv20mwjkkQigLV
 DUhaFknNHGhLW8rOdiS+auIgIzCP7FIFSOiBedC2i5YmaxBoFy0bhfwcgPnSXcyE/rWRHBy9Ku3
 V0YYdvYSTe5z/fEJfn/hvtN2FGrjy4U0ICSVpSRDcDq683tLHhOlG7uoAZ+RRmKmoqMchS6H2y9
 zNraN0eqmGMqSha0puR11yxBVgCKLZqQmIVmoOWvIm9bMGaVOFd1xG/zF8/E0VxftRhUfUop/nj
 NCvjBBQrA38LpnXZoKWzY1KTieJOkthzOaz6gbKBcmHXwQYue4DiVDkehp/bKzGhAsb1zCLGeIr
 l0a58U1u/6pBjG8C4ANhROqkCDTrWVI20zV4OruU4Z83N/uKpufTHzUmolLRO6WCUdRimtfV
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=68884e61 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=7ikdQer9Sff-Y0ePSHEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_01,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=981 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290028
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

Hi Heinrich,

Please find the answers to your queries below:

How to reproduce:
                 1.Take the upstream code
                 2.Place the capsule in /EFI/UpdateCapsule in the ESP 
partition (in kernel)
                 3.Reboot
                 4.U-Boot fails to find the ESP partition and continues 
with normal boot

Which caller fails:
/find_boot_device /function in /efi_capsule_scan_dir/ fails; 
particularly /device_is_present_and_system_part/ in /find_boot_device/ 
(line 990) fails for all boot options
                 In /device_is_present_and_system_part/, 
"/efi_dp_find_obj(dp, &efi_system_partition_guid, &rem);/" fails
                 In /efi_dp_find_obj/ function, in /find_handle/ 
function, this condition is triggered (in line 142): "/if (len_current > 
len)/", because of which it skips the ESP partition handle. From the 
below paths, we can see that the length of the ESP's path (len_current) 
is greater than the length of the boot0000's path (len).

boot0000's device path:
/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6e00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7e00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6c00000000000000)/Scsi(0,0)

ESP handle's device path:
/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6e00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7e00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6c00000000000000)/Scsi(0,0)/HD(1,GPT,2f2a74a5-4b82-da72-3110-7287ec562fb1,0x6,0x20000)

On 7/25/2025 7:31 PM, Heinrich Schuchardt wrote:
> Could you, please, describe how to reproduce the issue you are seeing.
>
> Which caller fails for you?
> What are the values of the UEFI Boot####, BootNext variables that you 
> use to find the capsule?
> What is the device-path of the ESP?
