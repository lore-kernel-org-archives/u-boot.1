Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB3DE8384F
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 04:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961E183AA9;
	Tue, 17 Feb 2026 05:04:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDkR7t++";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JYcfbz25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65BE783C32; Tue, 17 Feb 2026 05:04:46 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D787983642
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 05:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61GLsFkD006270
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 04:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lB34rzpLo6NhYvdLwXRNHAb5
 mC9p9xXk7acwIP2Pw2M=; b=dDkR7t++rkEhscYZFVPmCOizazwilmG2t3dtui++
 mAnOeqHhvIyAX2DKuciizxkGNkD/T2hNCPKMUzjnWQ5uSKmqXpVO/F1eqSm2FQXo
 VR4f6e1d5ltj1dMAelYwO3M4GQHP4uNV2641erl96kKwSwbSotZa5lhgI6qBo0Fr
 JOR4R8/zQpBUcTCHfBsqMXWWfAzbnArtNizDlVpiUB+9BzP7OiPKkJDtBLKGrBWc
 KpdNFIIQQnU81VlYxytdZe2wqWTjFi+fMhm2MFyxuKh5Df3TtkP+qKB1DS14jqiB
 jtjN4ZTQpAP6dl44XFQC0JdEDIk6bI/EJvwMDv0JIcFn6Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc5kh9ag0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 04:04:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354c0eb08ceso19064520a91.1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 20:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1771301077; x=1771905877; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lB34rzpLo6NhYvdLwXRNHAb5mC9p9xXk7acwIP2Pw2M=;
 b=JYcfbz25NAEGJ641G/BDSqnOx9lJ3foPxByI1zNSpkFG7N1THu0dyJyfqYmoMaCeSo
 t0HXlMU0QOcZ8kUCy+Z5UYRj2nOvoUWROdPruvzBmEW/oNd7KEq1jAg3s9Ds6dpHAMz3
 AjTqUhASV5YM6x6ATg2tLFr4Z24yhM4b1nU0MZp2P4XOivGAgavafN+PpAfiDG+OKIwd
 oUMYCLxMsDsG8TkKd7CyfV9m5ADRVsHnc8uqYXNvy21oD3TKzyK6tCLV9mLQQqHtAlUT
 7zZ2QSm3Fhww2PxESLGpeF7573AKn65fDu5G3SW94lWN/WvPTsXndYbBg1FvV7QDjxbY
 KwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771301077; x=1771905877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lB34rzpLo6NhYvdLwXRNHAb5mC9p9xXk7acwIP2Pw2M=;
 b=MDpuDPVJ1M1oDfgrSpkotfNwYQJhDECjFyN05VHHs3pjGcxmv+pt7eQgMX4iQqURdD
 9jodhdSNqeEg+p6E0lA2EdAr5kb+MOzIg8966MUcHJCQiSOyoPE4YZLiy2PFn8k0aY5Y
 avPNubDKjkcDyFm/wadQk9eDI3i8cg1SBlnd2yQHQ2T3dFsLSnr+zpGAeeVEeVaUvfWf
 g5Kl26dAInLCKjK8q59F7/yWleChyGncHI2cpYsXl2C4RqCX/9mkBTXciEUD1LydraS5
 YrJohCQ1LYuvdDBWPfyNWNmYlwXctSLNsRps3l0nTR3MoXs6E1tceCGgssqY1kajdItM
 PCJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOieogmHxXo0dCFtLCxR7xPaFJLrX66iJkSEISfAx1imCGZy00/uVfKv0iHAMedz1sPLXcU+I=@lists.denx.de
X-Gm-Message-State: AOJu0YyaHk6TJ/79y2vPzOCdTmWi276Pp1rCguQqlKdU0RP34jnpLFc7
 wfvQH9MSY3xgcLo+HPPEeuIesiq2lN4EX6TuPkN+MHEehZZ4YfmhZhq7FrXV1wd4MPwLH/zUAiY
 7vIgXrTJ9exZIkuPUN8chcsRcl0UXQcjl4ag3MbtBaDoAfLGLpTwBEv1F
X-Gm-Gg: AZuq6aKEXUNVjHGxvx86hTvHAYIoWcsQs8oFVU+TfthFgEEhLHLBkBb1r77t1vkTI8l
 +xVfNm7jGaKp54AhSydsW1E0Bg+86dLFl33MFYPp8iOGhSLfaLRrbYsJAymSGLldbfz1XmN6+Zf
 fXUlvx3S2S0jVVSP4o3oYUQCobX4DbF87xLwl0SP76ie/x9hKF5xeMiqLw8v0J0wm4HWQur1Mr9
 axdJJPhqVy5cidt92EDVoDdKhTz3W4rzz7xet/YUAtGXSJ5PzCobt8HEClv7alBj7gPTZAUJIel
 uf5TR+Md9tnfj3Izqmn8IpEm3gPFzz+TsGbBR/7qm0LmKsem3aYeCpKthqVfGZqrmbfk+oTkzrm
 6mblrE1TBlKRwzwM5ncL0ewFrHhU7KWa8oAzJj2OYnsBtjZj2FRrBTjOhS2Ze1ZI3LzEmzwfZxK
 m9Y8SlbBfBHytTvXjlu8neIxnH2MOL+vN6LBEIqmI4kDz2ZOxgT1M=
X-Received: by 2002:a17:90b:380c:b0:34a:b1ea:664e with SMTP id
 98e67ed59e1d1-356aabc1d2dmr12611856a91.15.1771301077199; 
 Mon, 16 Feb 2026 20:04:37 -0800 (PST)
X-Received: by 2002:a17:90b:380c:b0:34a:b1ea:664e with SMTP id
 98e67ed59e1d1-356aabc1d2dmr12611839a91.15.1771301076684; 
 Mon, 16 Feb 2026 20:04:36 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35662f8cd12sm19954388a91.16.2026.02.16.20.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 20:04:36 -0800 (PST)
Date: Tue, 17 Feb 2026 09:34:31 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 gabriel.dalimonte@gmail.com, u-boot@lists.denx.de,
 caleb.connolly@linaro.org
Subject: Re: [PATCH v3] fs: fat: Handle 'FAT sector size mismatch'
Message-ID: <aZPoz8cbECJ4nK9K@hu-varada-blr.qualcomm.com>
References: <20260122063442.2622684-1-balaji.selvanathan@oss.qualcomm.com>
 <20260128204102.GA1740001@bill-the-cat>
 <0d815ef4-0a9d-4aa9-95bd-580320357531@oss.qualcomm.com>
 <aY67Z87tM28Dtw76@hu-varada-blr.qualcomm.com>
 <20260213143907.GE2747538@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213143907.GE2747538@bill-the-cat>
X-Authority-Analysis: v=2.4 cv=Coyys34D c=1 sm=1 tr=0 ts=6993e8d5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=YfCOm-DyAAAA:8 a=XpE1AkgCAAAA:8 a=5p_tG3gqAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RNR-BBOG6lZgC77PY5EA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=zQLMK8awuJ6_Hvp-_9Ux:22 a=dpZMgbseYPk84XhQl7oQ:22
X-Proofpoint-GUID: epZ8N6ACwUzPhVz3JQfJ8rHzDFTDzyB_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDAzMCBTYWx0ZWRfX/KQx5Vcm6GNB
 J9vJSmrSC0JiOqd8ZisaGDjx12H2YYKiyDtkrRyqOM+3j169pOJm+xw1pv7R/AMAPCbkreJGMPF
 N4w86Q8ptRXwygAW9WMjH4Gudk8HMhqbNjk7UKv84QSBXlFV30/vakc6Bjx70xvujZpQh1Ws8p1
 Vtg6AMryvRMxiyFRxttqrgpWC1UYTDkMnRWCIsuCkcNinXplMpw9UWEosEpndk40y2jfpabpw3Q
 1+0t/biAq0P8B/PpsCEEEYFd8diOv+t+2MBLyaGSG0hgxXPbNsV360ky5pCBdVzXzcgUHiL0yqJ
 o58FjF1tx0HEiUlDpan3lMIyTlB16EcxOMYC0ln+Bm6FdLhDQP1ygmylXP/TDeG0lQKz7NKYeJ4
 VWW55A/QCiGIXr3Q1yOdiwpylkxi9AnMe9a+IFPEr5d41eGz3zp1YcvB92h+/ZeMfX5fFYKDHyw
 R1peFUWgktAqN3R1owg==
X-Proofpoint-ORIG-GUID: epZ8N6ACwUzPhVz3JQfJ8rHzDFTDzyB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170030
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

On Fri, Feb 13, 2026 at 08:39:07AM -0600, Tom Rini wrote:
> On Fri, Feb 13, 2026 at 11:19:27AM +0530, Varadarajan Narayanan wrote:
> > Balaji,
> >
> > > On 1/29/2026 2:11 AM, Tom Rini wrote:
> > > > On Thu, Jan 22, 2026 at 12:04:42PM +0530, Balaji Selvanathan wrote:
> > > >
> > > > > From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > > >
> > > > > Do FAT read and write based on the device sector size
> > > > > instead of the size recorded in the FAT meta data.
> > > > >
> > > > > FAT code issues i/o in terms of the sector size. Convert that to
> > > > > device sector size before doing the actual i/o. Additionally,
> > > > > handle leading/trailing blocks when the meta data based block
> > > > > no and i/o size is not an exact multiple of the device sector
> > > > > size or vice versa.
> > > > >
> > > > > Tested on UFS device with sector size 4096 and meta data recorded
> > > > > sector size 512.
> > > > >
> > > > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > > First thing, clang shows a lot of warnings from this:
> > > > https://source.denx.de/u-boot/u-boot/-/jobs/1365316
> > > > Second thing, filesystem tests do pass:
> > > > https://source.denx.de/u-boot/u-boot/-/jobs/1365314
> > > > Please make sure v4 is put through CI:
> > > > https://docs.u-boot.org/en/latest/develop/ci_testing.html
> > >
> > > Sure, will address the warnings and will put v4 through CI.
> >
> > Have posted v4. Please see [1].
> >
> > Tom,
> >
> > The CI failed while building am33xx kirkwood. When I locally reverted
> > the v4 change and tried to build amxx related platforms, I was getting
> > similar errors. It doesn't appear to be related to this change. I might
> > be wrong. Please let me know if that issue has to be resolved.
>
> This is presumably:
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=12821&view=logs&j=a007cd84-3be0-5a02-8a7a-a34fb3052485&t=216c79d4-eaff-5600-0b8f-3a63c01a45d6
>
> And yes, you need to fix that. Your changes lead to am335x_evm
> am335x_hs_evm am335x_hs_evm_spi failing to link due ot overflowing SRAM
> size.

Have posted v5 addressing this [1]. Please review.

Thanks
-Varada

1 - https://lore.kernel.org/u-boot/20260217035643.2383088-1-varadarajan.narayanan@oss.qualcomm.com/
