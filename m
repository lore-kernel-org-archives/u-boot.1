Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C47CCD5BAF
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 17:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF99B846A4;
	Thu, 21 May 2026 19:08:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nNXpnDAO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DoRycQEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2A31846BD; Thu, 21 May 2026 19:08:32 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 952B0844CF
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 19:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=ricardo.salveti@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LGm04i186083
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 17:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GORvpRX2uO97w56W2C026xI+xY1yYayGi9/3gsRykFQ=; b=nNXpnDAOh3OSlMWn
 XlqTegaJN7MoCvRlsZ2HeDFGQ5ItOhkHdE0nKDTPcrB3mjzQ/UXqdunUMZMsHFtv
 KDnZat8dL07HKACR1uUG6in3ux85LxDbnOH0ZgfhvaPtUmJpmVtwjRdzloVxsUdt
 ISqg41IRtme9vopu0fioWOQxemIZyXScE2kmaqBxEkY5Xs1pcsrdTi4SoA6PxL7i
 oPq4xrSpi776inLq5rh8Lu4HiL/3gTVG266v6Nm8lsV83Sghlw/2rLKMJB/3iCVO
 ErVB8IDctzlf8A139bK2AARUG9rBWLwxokoRgC0vq2Sfn/fbdBJXtc0115K+J2rf
 hqPG9w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9wahtg8d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 17:08:28 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ba115ab6bbso67356705ad.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 10:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779383308; cv=none;
 d=google.com; s=arc-20240605;
 b=hojKcGBJEcDeyGTpWYUnxCTU6QiA3PWY1i5lDfdHslMPtTcfLc7L0JXnJ7AJ8tU7I/
 EF6W23EJSlCbm5LZdDDSeLCrhg8PLrP44+JC7D15iYJV+FKOmgCFyAq/dOGQjHPQIkPc
 CIVTf/fUvHCReC2uC3zt31ncjk1iTUYayzgKM/g49fCra+f8mBrWJlH8EJqcsYZRnTQf
 4wP5T/m5EhIhyTPYh2as8Fs1cCphfuZGPqdF6rhQU5ZSa24QyIiiHjkgUf866bXyviY0
 xVeMZMIQ175yGcX0ZYRRRJno/OX+A5Bfga+LB2jNFtp6NUzZWAjoaPhZEadW0wSbe3Gv
 Nh4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GORvpRX2uO97w56W2C026xI+xY1yYayGi9/3gsRykFQ=;
 fh=3iNYg88dhW19GjVaCIU4619aPJN79/mDd+Kso3tHAOM=;
 b=aGFKyXD18XGiTXP2Tzx6Xu6uaRDc2E6bpUvEiYzbJtwMC5VQnFYqg8cs4Hm5IupCh7
 Hz3FwMmrZ1AYYDQvId2PUCS3EuB9aR86WSofBhfDUtJJfFvemWfyE7AudhaMCYUwMZqt
 Y1S/Pmog9QQBkk8LYSHuooztfTJ1pwhMrLV4Q4/vScSkl/DyH1A44yBzPS3O5v7aAP9+
 1RY2vYcfqKtdXUMECG31g3XzkjDPEZGV3RXdcsj0gtCziji1c+eVqVtM8ZLEPCvZBKPG
 ZEuN3gEDyPvTTULIFy/lRiQjC+bibbJSDRba3n8JgrYsqTsT+T1qBXfuvyKTLbZ315/E
 WENA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779383308; x=1779988108; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GORvpRX2uO97w56W2C026xI+xY1yYayGi9/3gsRykFQ=;
 b=DoRycQEl8bnO85VVKTGPzMJQJsMWls4IDf4cIpiOKw05ItKi9CVAKhPFFhSJsqyd3G
 NzvTPLhkeKoVQsPsUfrqcZk10RcQeVsWxk/JI6qzLkH1lAvK75KhvWaAYAp1xihuLVBM
 5rvRnXZ8Lbv3BiFT3mp986qx/i3sTWZi9YuB1W4eK2HUdX7tqmq/8QqBZxoI9sY6rP9R
 naWDrGBpQh8EfdrR6VsZjaA0lfLRW8imvfaZLKNVxHIp9Esa7iCrAIuSgPSQs/U/eOjQ
 QFMIfRxKBzBxX6hy9VA0QV/CvwD1m7FTWYIZb9V74JFu9Kpn/8xDdg1UvO0LM/2680EZ
 ZHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779383308; x=1779988108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GORvpRX2uO97w56W2C026xI+xY1yYayGi9/3gsRykFQ=;
 b=qDB5Jg4q1mgwu9Mm4XOafvAuzd+jJpvVs+vXDkqz8WmU1W/4ENIehUrwiVZC132kOx
 UuIl5SH6FUWugnQGEVV6EQnmGPDYkBaFzuk6fNxqLbYaE4e+6QIb1TNZW9QvgnZIIZ/9
 onvMeeC7KaRADAwMRNvLUHHmGK675/KcEWxW1kgbpMgm5ZZYomax0jNP0CCefxo3OdyN
 EEkncdqIabajQDPshJ345pogZJSVD5jbJOd4pmMDV+pJEPyc0cV9zJxnUfQag4NuxSbk
 BovUHt0hbwD8rsKC+iYd73mAZl20DtkgO5ZueNEElVnrj3lMb3BPSfEP/6vIfy2SMdPD
 n8JA==
X-Gm-Message-State: AOJu0Yynql4CDaENc4ilLVY9pdsahK1RElxWDGFAcXCnhL3paPfHd0i7
 D6crQf600/RaSbx7wzXVyN3gi8Cw2MsNcVtaJMxN+Rdkh6ePCRV2aRn0afxtWQMIjgo40LcUlCo
 nSMD1tLyCIhuxB1zy7DVwCZZAADm1obWOyrZDcMNsvpMLEU/V0DP3b22hyig8qwF0R3+sBixABX
 P/K4V5OjgAaiYyLys5mmYjNxWQnx4hFJETpssCaysP4w==
X-Gm-Gg: Acq92OFqq/g5DlEsRdFhRW2KkacCT3GTTDPB8rmqh6D+G+S75Y+dneupcpRus6yqHGb
 Ml/gHW4Xov0mZmQatpw2OUA5fRl6O0yxN9oGV8WC6KTlE4+r+hED0v3Ql9KpzCBt1eBwOyi6xDO
 VYvvq9s3inBp/gT77/RUc8gNPbez+USaVTgnVOarWT2zSi35WnKXDZVaRH2C4mdii5lusnHWfjd
 XGYMGA=
X-Received: by 2002:a17:903:3d10:b0:2b2:57f3:8d07 with SMTP id
 d9443c01a7336-2bea3068ca0mr40790875ad.7.1779383307799; 
 Thu, 21 May 2026 10:08:27 -0700 (PDT)
X-Received: by 2002:a17:903:3d10:b0:2b2:57f3:8d07 with SMTP id
 d9443c01a7336-2bea3068ca0mr40790495ad.7.1779383307287; Thu, 21 May 2026
 10:08:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260514205759.3553253-1-ricardo.salveti@oss.qualcomm.com>
 <ae4eec1e-1c5b-42d3-a26f-3911b1a2839d@linaro.org>
 <CAA_5yov+8_G2FUQ-QrKBtykt_vwZPdU-KGEzzmguYBJsUveqeQ@mail.gmail.com>
 <e13fe55d-1f43-4c07-a92a-045b0db9cf38@linaro.org>
 <CAA_5yosVpB6L6yN8gBAnMmxV7uSNjvyKtxeBV7ELGF+z18aibw@mail.gmail.com>
 <7b61004a-6166-4566-869b-7157e5563ff3@linaro.org>
In-Reply-To: <7b61004a-6166-4566-869b-7157e5563ff3@linaro.org>
From: "Ricardo de Araujo (Salveti)" <ricardo.salveti@oss.qualcomm.com>
Date: Thu, 21 May 2026 14:07:50 -0300
X-Gm-Features: AVHnY4K08vtuPbj5dgdsV5ddh-Z4Z2i59-A1cNER4taPHNTEOxheAjru_yiaDrA
Message-ID: <CAA_5yova4YXN5GssCtZ-dYd94K9Ms6yqkA7zZepbtK0OxsW-3A@mail.gmail.com>
Subject: Re: [PATCH] board/qualcomm: use bootflow for default boot
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, sumit.garg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDE3MiBTYWx0ZWRfXxRd0mz0zplXC
 q4k5uNuM5WbRk3NmQDpJs8BacbcJUrU3PEeO4nj+TK2r76bgQOFvCORcj9hiGczGdFlUsiU8X/4
 OxHuJ0sabLcx4dr6SWrPeM/yjWRf1NLMk6wZxMcVzqCkePiiClRw4ARPs5F8kLiL0sUrJULXk5Y
 ZawDdR28wfZ2mJxfTq78Uw+m2GuKbChChCskv3OUTVI4kfgMS/k7NBvEaX8i5H5gokDZJdoE5a0
 HfWLhzwnp1HuRUer0la8yyfd+knvsdslA9hDMWgNlFuLDOm82vAv5kLNWz757hd0yo8eJMheQnB
 BYFUhjbrmBpZIv0jnt/zIpiiUcWzA0WwqInB9u9YYUmkWBw6+ZRLVSE+yuUvxn9yoXZveygclzT
 uZywk+rywlGFVMR1KozkZoQOKr2ad8flnHIqP7kIa5zkn0UA5u32WV4ryIBWideYixaMvfwzW9A
 C6tJOGYjIvJyK6MKnyg==
X-Proofpoint-ORIG-GUID: xGPDCd0TZVVi9tYk-rkUvxH_jUD_siZX
X-Proofpoint-GUID: xGPDCd0TZVVi9tYk-rkUvxH_jUD_siZX
X-Authority-Analysis: v=2.4 cv=H8LrBeYi c=1 sm=1 tr=0 ts=6a0f3c0c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8 a=7RjKZRpLkicZq_DX0qMA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605210172
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

On Thu, May 21, 2026 at 12:32=E2=80=AFPM Casey Connolly
<casey.connolly@linaro.org> wrote:
> On 20/05/2026 18:32, Ricardo de Araujo (Salveti) wrote:
> > On Wed, May 20, 2026 at 12:08=E2=80=AFPM Casey Connolly
> > <casey.connolly@linaro.org> wrote:
> >> On 18/05/2026 21:15, Ricardo de Araujo (Salveti) wrote:
> >>> On Mon, May 18, 2026 at 4:59=E2=80=AFAM Casey Connolly
> >>> <casey.connolly@linaro.org> wrote:
> >>>>
> >>>> Hi Ricardo,
> >>>>
> >>>> On 14/05/2026 22:57, Ricardo Salveti wrote:
> >>>>> The Qualcomm default environment currently boots only with
> >>>>> 'bootefi bootmgr'. This bypasses the standard boot flow used to
> >>>>> discover extlinux and script boot entries, which are commonly used
> >>>>> for FIT-based Linux boots.
> >>>>
> >>>> We intentionally don't support these alternative boot methods upstre=
am
> >>>> as they aren't standardised or supported by typical distros. There a=
re
> >>>> also plenty of inconsistencies in Linux userspace depending on if SM=
BIOS
> >>>> (DMI data) is provide or not as well as EFI runtime services.
> >>>>
> >>>> Could you explain a bit more why you want to support extlinux and cu=
stom
> >>>> scripts?
> >>>
> >>> My main use case is for the target to automatically find and load fit
> >>> images by default (based on the config used), which is a quite common
> >>> use case for embedded distributions and products (see that it is also
> >>> enabled by default on several other platforms in u-boot).
> >>
> >> That's understandable, and yeah I'm aware that embedded distros have a=
nd
> >> continue to use this approach. I'm kinda wary of (and should have
> >> disabled) bootflow, the code for it is a challenge to understand and i=
t
> >> has caused me headaches in the past. But aside from that, the default
> >> environments we ship upstream are the ones that are actively maintaine=
d
> >> and used, for qcom that's EFI.
> >>
> >> I'd love it if we /did/ actually directly have users of upstream U-Boo=
t,
> >> but as it stands today anyone shipping it will be making some
> >> customisations to it.
> >
> > We expect to have meta-qcom and u-boot upstream supporting both FIT
> > and EFI-based boots, the end user can decide which one to use, and
> > that is why bootflow is useful here.
>
> If the idea is to have qcom docs suggest using upstream u-boot directly,
> I'd propose submitting a config fragment and a custom .env for the
> dragonwing platforms.
>
> I'd also strongly recommend against bootflow, you can just chain
> commands together "bootefi bootmgr; bootm ..." to implement fallbacks.

Would it be fine to change the patch to add bootflow after "bootefi
bootmgr" then?

> > I agree that EFI is more suitable for generic distributions, but we
> > expect that some embedded products will leverage FIT directly, and
> > disable EFI entirely (e.g. faster boot, reduced complexity, etc).
>
> I'd expect those products to fork U-Boot already and/or send specific
> support for their board configuration upstream.

They will probably all reuse qcom_defconfig, which uses
board/qualcomm/default.env, and that is why I wanted to have bootflow
available there by default.

> > Since FIT is already widely known and used in u-boot, I think it is
> > good to also support it by default here.
>
> Appeals to popularity go directly against the point from my last email,
> booting without EFI might be justified for your product but that doesn't
> mean the /reference/ Qualcomm env in upstream U-Boot should support it.
>
> The reference env upstream is there primarily for testing.

I would say this is more a personal preference, my thinking was having
both enabled and available by default to facilitate the life of every
developer/user.

Thanks,

Ricardo
