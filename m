Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301BAC44500
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 13:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D9684A4D;
	Fri,  3 Jul 2026 15:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="S/0LbE1O";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j8x/w4zt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8725984A4D; Fri,  3 Jul 2026 15:01:46 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF1384A4C
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 15:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663CK3bQ3144370
 for <u-boot@lists.denx.de>; Fri, 3 Jul 2026 13:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tL7AIow0cT3euhrEAsHk/36/NmGvwHJ0GqMmeXIZuMc=; b=S/0LbE1OHem9y0oj
 yMmZC58h22gQBxsCGvI54vwl+wfl1abo6liFrStKZRBGqlI+bABdW/ioc+Q0ILBg
 dSPxlIPOd779dkktDhvCW1u3FawiLN+BMfsnh5dYbVxi1B3WVepidRyO+hgWJEUg
 xhi1ndt2sqsplc705zlcnkptYtFY3KOA+Ply9FS/3RZL3MqUmsK77DWZOYLP++eq
 PPK3+Y3nx9B32OSQEjfRsdMgrcVo1E43yAVqLXNDBGkp+OLntO8uUgcjQfAxviXq
 10PoVtk2R6MvnvVrpAo8vbZZ6GYkAahgxhSS/WmKjgu41CFHfxpibWZakr9KpkBT
 7wuiIg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682bsddh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 13:01:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-380ddac2b02so815858a91.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 06:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783083701; x=1783688501; darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tL7AIow0cT3euhrEAsHk/36/NmGvwHJ0GqMmeXIZuMc=;
 b=j8x/w4ztGplJdBILzambsOagsAtJ+xoNdTK+BrhY5SGkJ+BQt6w8gFsRj2ShZNKODE
 ANM1Z0aSz3UhVg7PoJ99DMfjFc9Xlb6Jw0DHA54DPcHsMiSzIi5dqRetFCVQ6ABBgrhh
 t5OtVXaYoAfwVpgV3PcnZwM1wqxylGVaiQi1atIOs7XUKZPTvc8+h5APXRzWlS/6/8us
 NEmu8ZNY7nIXpnDOeBFFyZ6TvYSy5Ci91XD7uWh8lvlEQ4/2loZiYWmVuGdR7CgOUnC0
 bEb7A2UAR5OMzs+eg7m4jpOQhMOObNg5oCvSRwWj8Bf/3xKcf4PH1uacNASoTKboQHHZ
 JThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783083701; x=1783688501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tL7AIow0cT3euhrEAsHk/36/NmGvwHJ0GqMmeXIZuMc=;
 b=T1WASq8Q2OyjTauXd4cWM31G1+u6zFL0gavJSHV/7M2SpXeUvoZoM4g54AYyWC5xAv
 J23xRt3NShzEDtkIrqXxx8Zkc51aG8tnQWLpG9VxrFfqZO/H/S1KQfZNaA3k65v7IK8K
 Vy7OGR2QSFYlbbafRg/H10qNFBZ6SaixMO1I3kXeyVhILhLlmww9Ix93B/DgRK2zFmYy
 QxHKnvUMhp+74/RIsqXwu2vmi4FJMNbmh182l4zaUFk6eB5mxkFsSJJQlDNo/YforuQj
 oaJB2aZfbooVbeLMak7UHU25o76kdL/gTfEXk8+X4SiO0a9Q0hcPWb38MDUK86Th0IoB
 AJyg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrwv3iiPo83OID5nzaUdca9LL7BJPVjcDpOG8faqvZQW4js/S4W2Bv7ualPQwrTOoyg/qFlGx4=@lists.denx.de
X-Gm-Message-State: AOJu0YzaLW+ARFTN+aZ+FtBtKtABOTjT6n1qdwdUrRkYhtI9119SBgKC
 GuAwvhUxzJO+PuR+IHdre8ueIVQc3tkg7e3wYDRqFGic9tyDSCSdRucXSouYQNzVU/mvcPhSTD2
 GRf/S/7UtAVsC+HMW5KCY8cruoyQuNvmrljbAtQ/3UobeWckK9o/2C4fZ
X-Gm-Gg: AfdE7ckkdoUxpyU9ezDzl0uA353Fecmb92ywfI5uXitHsS9/iYjcKOsKR/SUeCJqvWb
 9Gc9sQSyZKWvSl833hbPy/q09dVJB2ScMAbVeemFdiiIy0Jv6KmLgD45Y1fiLrfdAV76ObTEUuw
 +WCPiMpKS2tX1sBMI3GGL8ncU4XGmhw60MNnn1WvyJMm+cPD7zn3/qPepRQ94rnG9q7amoW6IqW
 AhpSJedTKG7WK3UMsdl1Fs8vVllwsfabg/JuPVAl2wMxGrKIT/aA+XI/e9GXMG9JvVRzuUfij7m
 PbV4K1YAs792W4PsxlQV9RYakiK+lMIb2nXaIfCQ9Tzet8yMd/OVUfjl1VSD+loH6p4LUhCZ9Y8
 IyofnfeCG5Y3lhUndGoHTaFAMhN1KE7+ZTnZWCabYZb4=
X-Received: by 2002:a17:90a:fc45:b0:381:b1ad:c9e4 with SMTP id
 98e67ed59e1d1-381b1adcdccmr663971a91.26.1783083701098; 
 Fri, 03 Jul 2026 06:01:41 -0700 (PDT)
X-Received: by 2002:a17:90a:fc45:b0:381:b1ad:c9e4 with SMTP id
 98e67ed59e1d1-381b1adcdccmr663621a91.26.1783083697653; 
 Fri, 03 Jul 2026 06:01:37 -0700 (PDT)
Received: from [10.152.202.155] ([202.46.23.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b816a42sm35197962eec.9.2026.07.03.06.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 06:01:37 -0700 (PDT)
Message-ID: <6f8e31ce-8e3d-4b91-807a-c2252301456e@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 18:31:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] configs: qualcomm: Add secure boot config fragment
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260701122225.1628456-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260701122225.1628456-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfX0m2TD0vazOIO
 kGtP+wuvucpYG/EOVZSOGWG0qbGPTVpoCkQKUrCM0KCRp1wAd17vA4qdj3qXWq19PfQ4XIrrOju
 QldRJlCndkvVeYpQlBa6yQJziTn0i6eippk/1LnrDNZ7/FLTlT71Pflz2vwbX1l3RFOoRa6VO4y
 OM2xGgFJrsvtaHtCigaMOc98Wyw8+N9riyEku8Y68dZmZwaGVRD68ol52yunHxpUjtr2upRpPbR
 Shup/hZ0VuKtf0u5L/D/+ZHJa55oOFvZqnKNg058w7tmsvS/wMCZQmFWXBVRf0D9sUEgfIPvv4T
 jaDAoJSUznSPhVytIM5lqVaoEXwyrQQ5aJp+eZXY9o0fDA8CPJq7w/w53Jg6q8ALCUElyz4ZjFI
 NKittL4yGSkPwQR/KFg8uLmEJRVoIGajj9qD5yKdNXSntvhHQ/7VXdn+VXEY6XZ+9L3JHJ9K4HV
 o13ZGdsv7uSrOYR0OXA==
X-Proofpoint-ORIG-GUID: HjznfBevSMjiISEZalu_qhyeMeewO5xP
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a47b2b6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=WUbZ1dZLsFjBWW6z5HUA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyNiBTYWx0ZWRfXyRrIcCpsUa2d
 7K2RGcByIrXj1M6nW/u3ndtVIZRitEE1jtTfZvalxFS8i4Jw4CZdOcLfI9qMRbpWHbXdoKhDAUW
 qOMwVxS1nYDeCbPxjC7ibWSjxLjFIUY=
X-Proofpoint-GUID: HjznfBevSMjiISEZalu_qhyeMeewO5xP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030126
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

Hi Casey/Ilias,

Thanks for the feedback and apologies for not providing enough context 
in the commit message.
The intention of this patch is not to introduce a complete Secure Boot 
solution by itself, but to provide a common configuration fragment that 
enables the EFI Secure Boot framework and the required hash algorithm 
support across.
When these secure boot configurations are enabled, a persistent EFI 
variable store (ubootefi.var) is expected to be present in workspace 
before building. Platform keys and signature databases (PK/KEK/db) are 
provisioned into that variable store using the efivar.py tooling.
At boot time, U-Boot loads the EFI variables from ubootefi.var, and EFI 
image authentication is performed using the enrolled keys. The 
expectation is that kernel EFI images are signed with the same keys 
enrolled in ubootefi.var, and are authenticated by U-Boot against those 
enrolled keys during boot.
I agree that this fragment alone does not establish a complete platform 
secure boot chain. My goal here was to avoid duplicating the common EFI 
Secure Boot configuration across Qualcomm boards that use this workflow.
Suggestions are welcome on whether this should be handled differently. 
In particular, I'd also be interested in exploring Ilias' suggestion of 
integrating efivar.py into the EFI loader build flow so that a default 
ubootefi.var can be generated automatically from the EFI loader 
Makefile, rather than requiring it to be created as a separate manual step.

Thanks,
Aswin

On 7/1/2026 5:52 PM, Aswin Murugan wrote:
> Add a common configuration fragment for EFI Secure Boot and the
> required hash algorithm configs to reuse across Qualcomm boards.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   board/qualcomm/secure-boot.config | 6 ++++++
>   1 file changed, 6 insertions(+)
>   create mode 100644 board/qualcomm/secure-boot.config
>
> diff --git a/board/qualcomm/secure-boot.config b/board/qualcomm/secure-boot.config
> new file mode 100644
> index 00000000000..21f567e1a45
> --- /dev/null
> +++ b/board/qualcomm/secure-boot.config
> @@ -0,0 +1,6 @@
> +# Enables EFI Secure Boot support
> +CONFIG_EFI_VARIABLES_PRESEED=y
> +CONFIG_EFI_SECURE_BOOT=y
> +CONFIG_FIT_SIGNATURE=y
> +CONFIG_SHA512=y
> +CONFIG_SHA384=y
