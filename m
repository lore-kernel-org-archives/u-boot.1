Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AC1C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 09:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E5181EC0;
	Tue,  1 Apr 2025 11:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="mFNzX+9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC5181F4D; Tue,  1 Apr 2025 11:31:27 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9679580194
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 11:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5315CXZc025871;
 Tue, 1 Apr 2025 09:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=SNIJ9SJsaJrZfG6zrDviwUgj
 Ug4gHKxvD8tKGIKnp1I=; b=mFNzX+9AINva82IyMRDmTeKVQEyteQ6dKYCiOevi
 +R+kgcwNh7NvPHT5nB6zuCjGQ/fDHtK079qDywBpGCI7L/vvIuCq9Znp71yJDvL+
 20v4FwivzXmy0UVqVoFyo1gVC4ecZ/aJt9qV+bH+9KVQGaQWJ+vY+ouThrgXR/1b
 KXOUUBivYyMX8mhQiRVYRPm1ieD5uET9rtWVp71bboJ6q1P1jd3Y7zaMgknWK4Fj
 t6zU3oBA/GVGRd34pSJu1Mwp9cZ6gyOwumkY1VDISoMKt4WRx86+jYkYLtGfpNHh
 WFEQP41qFkd3HkLVrir7Yll8554lMTL6Hk5sqK/n8xBGCw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p6jhqkus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 09:31:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5319VHj6000838
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 1 Apr 2025 09:31:17 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 1 Apr 2025 02:31:13 -0700
Date: Tue, 1 Apr 2025 15:01:10 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <EABachinin@salutedevices.com>, 
 <jerome.forissier@linaro.org>, <rasmus.villemoes@prevas.dk>,
 <ansuelsmth@gmail.com>, <sughosh.ganu@linaro.org>,
 <michal.simek@amd.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
Message-ID: <Z+uyXhPxpm49c4kT@hu-varada-blr.qualcomm.com>
References: <20250326054653.273906-1-quic_varada@quicinc.com>
 <CAC_iWj+MPcOcuhM1vcHyXYUF7O7U_y8+KKMZJszTK2aqfgfHZg@mail.gmail.com>
 <Z+TsLpAGAIezgPZS@hu-varada-blr.qualcomm.com>
 <CAC_iWjKyyOHCU2xv-x9BW9w7GtY8ohupxNKTTJC0V91dfPwy8Q@mail.gmail.com>
 <Z+uL1TQlh+ayjF+G@hu-varada-blr.qualcomm.com>
 <CAC_iWjK=-qVD2=SM=fT7JujRPZi5HWht6rjbU_174UUyWYezqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAC_iWjK=-qVD2=SM=fT7JujRPZi5HWht6rjbU_174UUyWYezqQ@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: EFmLmpnHlNA0n6xyevgtAIggO-3uenwp
X-Proofpoint-ORIG-GUID: EFmLmpnHlNA0n6xyevgtAIggO-3uenwp
X-Authority-Analysis: v=2.4 cv=bZZrUPPB c=1 sm=1 tr=0 ts=67ebb265 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8
 a=hjTAyhxO27wObOj_DTAA:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 mlxlogscore=781 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010061
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

On Tue, Apr 01, 2025 at 10:02:05AM +0300, Ilias Apalodimas wrote:
> On Tue, 1 Apr 2025 at 09:46, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Thu, Mar 27, 2025 at 11:22:58PM +0200, Ilias Apalodimas wrote:
> > > On Thu, 27 Mar 2025 at 08:12, Varadarajan Narayanan
> > > <quic_varada@quicinc.com> wrote:
> > > >
> > > > On Wed, Mar 26, 2025 at 09:28:04AM +0200, Ilias Apalodimas wrote:
> > > > > Hi Varadarajan
> > > > >
> > > > > On Wed, 26 Mar 2025 at 07:47, Varadarajan Narayanan
> > > > > <quic_varada@quicinc.com> wrote:
> > > > > >
> > > > > > If the EFI runtime services pointers are relocated even though
> > > > > > relocation is skipped, it corrupts some other data resulting in some
> > > > > > unexpected behaviour.
> > > > > >
> > > > > > In this specific case, it overwrote some page table entries resulting in
> > > > > > the device memory address range's mappings getting removed. Eventually,
> > > > > > after the completion of efi_runtime_relocate(), when a driver tries to
> > > > > > access its device's registers it crashes since the mappings are absent.
> > > > >
> > > > > How were those page table entries added?
> > > >
> > > > initr_caches ->
> > > >         enable_caches ->
> > > >                 setup_pgtables (arch/arm/mach-snapdragon/board.c)
> > > >
> > > > > The runtime service relocation might have overwritten those now, but
> > > > > since they are not in protected memory this can happen arbitrarily.
> > > >
> > > > To avoid relocating U-Boot, I had OR'ed GD_FLG_SKIP_RELOC to gd->flags
> > > > in init_sequence_f -> mach_cpu_init(). Hope that is the right place and
> > > > way to do it.
> > >
> > > I'll have a look at the relocation stuff, but off the top of my head,
> > > I don't remember.
> > >
> > > >
> > > > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > > > ---
> > > > > >  common/board_r.c | 3 ++-
> > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/common/board_r.c b/common/board_r.c
> > > > > > index 179259b00de..1dd3b96c2de 100644
> > > > > > --- a/common/board_r.c
> > > > > > +++ b/common/board_r.c
> > > > > > @@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
> > > > > >          */
> > > > > >         efi_save_gd();
> > > > > >
> > > > > > -       efi_runtime_relocate(gd->relocaddr, NULL);
> > > > > > +       if (!(gd->flags & GD_FLG_SKIP_RELOC))
> > > > > > +               efi_runtime_relocate(gd->relocaddr, NULL);
> > > > >
> > > > > Have you tested booting with EFI with this change?
> > > >
> > > > Yes, tested this with both GD_FLG_SKIP_RELOC set and not set.
> > > >
> > > > Used the command 'bootefi bootmgr' and Linux is able to boot.
> > >
> > > Have you tried to call any runtime services -- e.g efival -l will dump
> > > all the EFI variables
> >
> > Sorry for the delay. The test setup was busy. My U-boot doesn't seem to
> > have this command. Not sure if I'm missing some config.
> >
> >         => efival -l
> >         Unknown command 'efival' - try 'help'
> >
> > However, 'efidebug boot dump' works. Does that suffice?
>
> This runs at boottime. We want to test the variables at runtime so you
> have to boot linux.
> One of efibootmgr or efivar -l is enough

Please see below for 'efivar -l' output

	sh-5.2# dmesg | grep EFI
	[    0.000000] efi: EFI v2.11 by Das U-Boot
	[    0.001636] Remapping and enabling EFI services.

	sh-5.2# uname -a
	Linux qcs9100-ride-sx 6.6.65-qli-1.3-ver.1.1-dirty #1 SMP PREEMPT Wed Dec 11 15:13:43 UTC 2024 aarch64 GNU/Linux

	sh-5.2# efivar -l
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-StubFeatures
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-StubInfo
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderTimeExecUSec
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderEntrySelected
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderEntries
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderDevicePartUUID
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderImageIdentifier
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderFeatures
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderFirmwareType
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderFirmwareInfo
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderInfo
	4a67b082-0a4c-41cf-b6c7-440b29bb8c4f-LoaderTimeInitUSec
	605dab50-e046-4300-abb6-3dd810dd8b23-ShimRetainProtocol
	8be4df61-93ca-11d2-aa0d-00e098032b8c-BootCurrent
	8be4df61-93ca-11d2-aa0d-00e098032b8c-OsIndicationsSupported
	8be4df61-93ca-11d2-aa0d-00e098032b8c-PlatformLang
	8be4df61-93ca-11d2-aa0d-00e098032b8c-PlatformLangCodes
	8be4df61-93ca-11d2-aa0d-00e098032b8c-BootOrder
	8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0007
	8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0006
	8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0005
	8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0004
	8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0003
	8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0002
	8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0001
	8be4df61-93ca-11d2-aa0d-00e098032b8c-Boot0000
	8be4df61-93ca-11d2-aa0d-00e098032b8c-VendorKeys
	8be4df61-93ca-11d2-aa0d-00e098032b8c-DeployedMode
	8be4df61-93ca-11d2-aa0d-00e098032b8c-AuditMode
	8be4df61-93ca-11d2-aa0d-00e098032b8c-SetupMode
	8be4df61-93ca-11d2-aa0d-00e098032b8c-SecureBoot

Thanks
Varada

[ . . . ]
