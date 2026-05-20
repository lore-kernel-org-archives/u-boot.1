Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF2FCD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 16:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D3B84706;
	Wed, 20 May 2026 18:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="N421DUO/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Os6s04AF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4FDD847B0; Wed, 20 May 2026 18:33:08 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40787846DD
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 18:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ricardo.salveti@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9oM431177868
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 16:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vKieS1DPJT2wSuKrOjGgHoQCVygHGZfNSWvnAVefPuk=; b=N421DUO/mUOuvpnP
 WViNjIsqH+YjxEj31NJBu5Vqh+MZzdRGxmd1K38H/CzXYC7Sv06CSwEoE0c/ycde
 VSUtx75np4gvwaiw9wumnmcOUpa6K59UZaqySvJ4ZGWjlKWm3fct0ISqfPRlIPJq
 +SqUfQYp5T2NVoN6XWF902zQUKRlk+YhjHO2s5if4aNBcPy/r0TuQY6xKqggGSJN
 kZVJ4BNMqW+CV4PhNz5GUZAxs+ACKt6fPj9TC1FmnMwtMip7w9EtwpMW2BBKzv8w
 0JR+EespdAmJ1cb9DGHTLaVIieCnUP9+X6J5kUTv5GDpfzFFI075wckWYlJ6/SWi
 6Kf/Gg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6sj9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 16:33:04 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-366344513a3so10762606a91.3
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 09:33:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779294783; cv=none;
 d=google.com; s=arc-20240605;
 b=Vm+xfuT9IfucApr8THm4uuFoXblQBqw4+5mZ67bFDjaJTdVMIcAzWAhI3c8vMFdEiQ
 f8XCq7FEWCGwgZvSAuKuuHHtxLvRRvqC2AZJ1Xb1V1NtF18zuR+oNRU5zZanoWispiHL
 r5Kxr7SL4TQnJAC77sc8Ndjw1V1zKJnswXb+hSyKCXsbFcnJNfOE6shQahzk2yKwB5ev
 mC+Iu7FaEEo2S1Co5wpRPTP8c5TLiPNyXAHT+sb9k8WVxBIlY4Sy07+Ra8oyUTa+6OsQ
 hvjSnCOJy5+YIJWWFlWYfNhe2MAX21gReD/FbmrqTfbZ03T/d4PtVvuvFG3uOU27Dqpw
 uYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vKieS1DPJT2wSuKrOjGgHoQCVygHGZfNSWvnAVefPuk=;
 fh=3iNYg88dhW19GjVaCIU4619aPJN79/mDd+Kso3tHAOM=;
 b=LtdRVe2ecHqHvfISxiTrlp4iWJQIMLLrz1J3B381l9EqeXxUIDQnezxAC4I/cHti7V
 PIrvcrykqTTSHUSowiciafLGkav/cq8I7ijDTRM6ovI6xf17iG8onQ3qdTulPRdA9rkX
 NG/iOAAM5LjYHWR+GPH19FeORaDzhThECr98LbXXpMYym8XOO/LLkVXB52HyanGf462R
 CMYy+nEFri3BaIEkav6mPHzAAiPHdA6Ybk8r4qw5SjOTpOqVE/eFGVIV/TTT0cjs8HJ6
 WCK2wfIcmLK7FdNn4QuOvONLnNy4utLnPgJkndy9TIivuCl3OdUrJNAX6zETsY2dPMSh
 wEhQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294783; x=1779899583; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vKieS1DPJT2wSuKrOjGgHoQCVygHGZfNSWvnAVefPuk=;
 b=Os6s04AFb/i86/LBqW4IOZUir+/nPBr1pFV00YaY1qAnSxPVnCsGxHUSBr9tuYX3rx
 eegkiXeI20L+i6jyKJZ90iY4vCDu4ktboSDyjTufooNd7zvxUGQaqcb0YnxNsqA99s3V
 BY1eKOKEqSNfNfDq94nRSJuX1zSuJYtOFjIxw1jnW0aIymtWoHVjiDMiBfYqtXWrm/m+
 NiE9p8O1UGId1RBLt2gnXU3QVhJRurnWX8PF2W5j5LguA283tDd4R2V086g3BzLOx2v4
 6nFRb4Zt5FOHHlM6wF9mWhpRTSJCFX+EIMHaOioQEwNo9+VO0cRgiuKyZfXqaqXvBpDA
 rAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294783; x=1779899583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vKieS1DPJT2wSuKrOjGgHoQCVygHGZfNSWvnAVefPuk=;
 b=faHAiB0cCRgYkb2Fsf/7a/WFx3Q368dJvRdLSIDDMV3j7AiZGbNbr8R6TwiWzSxanF
 +mu32izwbkcIabeN3i7+aifdHs4A09Al1R/o+WlUKY5SZ2tc7TUz0H1OK97vqAk4MGKP
 fO5kklB939vc5YD5os2jAbyjbQLs/PpsebyKniuiwfFQ8ApJCxBtj9jVQox///FG23MM
 kP/Iab6fZvQuVTClN0rYH2NaO87F0IQjghLyRtPMQHBduvRZ87aLzxMbGUYJZQQ2tmQU
 bp7OEpId4n6z3Lw47AbLp2sIvxooeU/n9zLwC3k2x2ckfYLyyfn3HI9SHlEhJlZQNW2c
 g1Og==
X-Gm-Message-State: AOJu0YxXPMbOylMVUGUW8apGZplTxzUEiZfZynORTjD/nwevy2iSKzmX
 WDkO1CD47JobfFIJyBXvOGIbr6gAgZaktbKRdoIM9LZGPKTDSfYN1sq9RXW0LjXJsjKSQ2ySYD8
 E2iVi6B7i1Zyogdp2zU5RPNMDI1udnTtMy5iuhsu+Xc818VOyLMFypgHQKZzKsnfX3XksOGrVEo
 ZxHIU9Cg2yFBLO3zhjIPbqlNAv5p/3Vco=
X-Gm-Gg: Acq92OHrn79d1crklORe4eGaaLjbyC3Mml5Zug1Gi8PkpLxJOwMUBmkhiEwBqUr/8qT
 9rSkoiLPifTeH0x+F2r4wvUer5REEnHsLnvTAB9QWlQOYsqw/6I5cDf7ZFPvb9dk48uFVc/u+CR
 w1Et4bZrQFCsjzAxza4ju1HqPuR6dp/nSgHJonXBvi7qR6N+sWgCCAvDo289BETvnjCGUk1mg4p
 7cd
X-Received: by 2002:a17:90b:1d8d:b0:35e:3e86:e2d1 with SMTP id
 98e67ed59e1d1-369519df5d5mr24411742a91.7.1779294783449; 
 Wed, 20 May 2026 09:33:03 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8d:b0:35e:3e86:e2d1 with SMTP id
 98e67ed59e1d1-369519df5d5mr24411709a91.7.1779294782904; Wed, 20 May 2026
 09:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
 <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
 <CAA_5yov+8_G2FUQ-QrKBtykt_vwZPdU-KGEzzmguYBJsUveqeQ@mail.gmail.com>
 <e13fe55d-1f43-4c07-a92a-045b0db9cf38@linaro.org>
In-Reply-To: <e13fe55d-1f43-4c07-a92a-045b0db9cf38@linaro.org>
From: "Ricardo de Araujo (Salveti)" <ricardo.salveti@oss.qualcomm.com>
Date: Wed, 20 May 2026 13:32:26 -0300
X-Gm-Features: AVHnY4JkxzqWTTjg7QZlGRMc8WmFFJ7yxWkcuTDuZfAB21eWGXvBOcuBzK395uc
Message-ID: <CAA_5yosVpB6L6yN8gBAnMmxV7uSNjvyKtxeBV7ELGF+z18aibw@mail.gmail.com>
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, sumit.garg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: GsVbzKKoJIQOgB5mAHRSu21VM89tBPM_
X-Proofpoint-ORIG-GUID: GsVbzKKoJIQOgB5mAHRSu21VM89tBPM_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE2MSBTYWx0ZWRfXxYE67UFTyX3o
 M1vdgxwzzw0iKb9xEABFzn61exQSHLlp3jlguXZWqIL13vkPfmiy1SjGCN0FWTMssDw5d0V7Sna
 XlCzeWkDYncmNQFuIf1afSZFRYXSAOUBh7sR2jTPX+AUvImTaNh7wixCKKbZIUuBu6IcNbSE69o
 Gol8WVqX0zxwe/vSZYT3Nxx9r/HZRAJ2wUYYikdDDda4dOcw1J74u7IQdi9DFi3hhe2wQNzrNnf
 VNX14Fi1+w82vUfnZshCnDzR4Jv7Jwvh6L2aQJ2gBV0Bp8biaVQD9r3N2ioPr9yJ36rJ1axxgAS
 SWJuOh4WEEZwTwqEoW0GSIdUS5aRCFppKQEv+NIkhu5Xa79xedx5w97r7F8Jp8x7AvfvLB308pE
 ID0YOhVwIuyRNYdRvD3LbsitChdbxh5dyL6lap0shbAB7qImBjSIcJCeJup/2rRjv0HXymSXzrn
 LXwPz+BIvpL1uPIKsDQ==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0de240 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=KKAkSRfTAAAA:8 a=TXy59m5TfZN1O43iyncA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200161
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

On Wed, May 20, 2026 at 12:08=E2=80=AFPM Casey Connolly
<casey.connolly@linaro.org> wrote:
> On 18/05/2026 21:15, Ricardo de Araujo (Salveti) wrote:
> > On Mon, May 18, 2026 at 4:59=E2=80=AFAM Casey Connolly
> > <casey.connolly@linaro.org> wrote:
> >>
> >> Hi Ricardo,
> >>
> >> On 14/05/2026 22:57, Ricardo Salveti wrote:
> >>> The Qualcomm default environment currently boots only with
> >>> 'bootefi bootmgr'. This bypasses the standard boot flow used to
> >>> discover extlinux and script boot entries, which are commonly used
> >>> for FIT-based Linux boots.
> >>
> >> We intentionally don't support these alternative boot methods upstream
> >> as they aren't standardised or supported by typical distros. There are
> >> also plenty of inconsistencies in Linux userspace depending on if SMBI=
OS
> >> (DMI data) is provide or not as well as EFI runtime services.
> >>
> >> Could you explain a bit more why you want to support extlinux and cust=
om
> >> scripts?
> >
> > My main use case is for the target to automatically find and load fit
> > images by default (based on the config used), which is a quite common
> > use case for embedded distributions and products (see that it is also
> > enabled by default on several other platforms in u-boot).
>
> That's understandable, and yeah I'm aware that embedded distros have and
> continue to use this approach. I'm kinda wary of (and should have
> disabled) bootflow, the code for it is a challenge to understand and it
> has caused me headaches in the past. But aside from that, the default
> environments we ship upstream are the ones that are actively maintained
> and used, for qcom that's EFI.
>
> I'd love it if we /did/ actually directly have users of upstream U-Boot,
> but as it stands today anyone shipping it will be making some
> customisations to it.

We expect to have meta-qcom and u-boot upstream supporting both FIT
and EFI-based boots, the end user can decide which one to use, and
that is why bootflow is useful here.

I agree that EFI is more suitable for generic distributions, but we
expect that some embedded products will leverage FIT directly, and
disable EFI entirely (e.g. faster boot, reduced complexity, etc).

Since FIT is already widely known and used in u-boot, I think it is
good to also support it by default here.

> In any case, the other reason I'm wary to use any other boot methods by
> default is because as I mentioned we don't support them upstream, and I
> don't want to have to care if a change breaks FIT booting (for example).

I don't think that there is anything blocking us to support it
directly from upstream, and I expect that pure upstream should be
fully functional quite soon on multiple targets (some even including
SPL support).

> > As u-boot provides support for bootflow, supporting several mechanisms
> > which are probed at runtime (including EFI boot), I believe it is a
> > better default as it supports a wider range of use cases.
>
> In general supporting more usecases is better, but when it's something
> like how to boot the OS I do think it's much better to push folks
> towards standardising and EFI is that standard.
>
> Just because products and embedded distros today use other boot methods
> doesn't necessarily mean it's a good thing and to me at least it's clear
> that we should just switch to EFI...
>
> There's no reason not to adopt something like UKI, or even to write an
> EFI app that implements FIT booting.... But yeah, it's easy enough to
> carry a patch or point to a custom .env file if need-be.

That would be up to the user I would say, and FIT is widely used in
u-boot on other targets. From the u-boot side I believe both should be
supported, I don't think FIT support will be removed from u-boot.

Thanks,

Ricardo
