Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA20C36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 06:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9638817C4;
	Tue,  1 Apr 2025 08:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="betSmL4n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB62881879; Tue,  1 Apr 2025 08:47:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6D9180584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 08:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53169oqC024658;
 Tue, 1 Apr 2025 06:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=uY+zuZPML7Vw3mkGz1wqg28D
 J4Ah1BJuDySTDZRBN0s=; b=betSmL4nHCeSCR/ZgW65APssyCJZTEHo963ia1eD
 3Q4qu+RRyTZfFCex9OduRI+2aO0xqjkbjIfLhCM3nWAdk0bkI1AoawbQEEoM+Z0b
 hsdDELrb+ZPyvyROWqWzSrK3AV2r97LiKizDuj3G6+NmsPl7kN18L2Cygp87NPEb
 dvz5fAceLNKjsGR4esP3xB9lPG5Kyniq3m0ZV1lpYRFMO1YPkR5ZbGlRoXXcrhhX
 rSsHqUh6kIx8dn0Z97i6Wg8GKNjLRbxb+crPWip0zq5t2e/W7HaKEFa/ER6qy8vQ
 QqmSbkBngb9OEeaFtkC3UWtfJ8MVnC4QFv6N7NhCP8kVyQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p86kpv4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 01 Apr 2025 06:46:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5316kqRX032005
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 1 Apr 2025 06:46:52 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 31 Mar 2025 23:46:49 -0700
Date: Tue, 1 Apr 2025 12:16:45 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <EABachinin@salutedevices.com>, 
 <jerome.forissier@linaro.org>, <rasmus.villemoes@prevas.dk>,
 <ansuelsmth@gmail.com>, <sughosh.ganu@linaro.org>,
 <michal.simek@amd.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] efi_loader: Handle GD_FLG_SKIP_RELOC
Message-ID: <Z+uL1TQlh+ayjF+G@hu-varada-blr.qualcomm.com>
References: <20250326054653.273906-1-quic_varada@quicinc.com>
 <CAC_iWj+MPcOcuhM1vcHyXYUF7O7U_y8+KKMZJszTK2aqfgfHZg@mail.gmail.com>
 <Z+TsLpAGAIezgPZS@hu-varada-blr.qualcomm.com>
 <CAC_iWjKyyOHCU2xv-x9BW9w7GtY8ohupxNKTTJC0V91dfPwy8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKyyOHCU2xv-x9BW9w7GtY8ohupxNKTTJC0V91dfPwy8Q@mail.gmail.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=W8g4VQWk c=1 sm=1 tr=0 ts=67eb8bdd cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8
 a=KlY3ccEW07Cv9YtnVT8A:9 a=CjuIK1q_8ugA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: z3eZC297XJUc1Ezi7LJJx31PTS9lHOnf
X-Proofpoint-ORIG-GUID: z3eZC297XJUc1Ezi7LJJx31PTS9lHOnf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_02,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=670 mlxscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010045
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

On Thu, Mar 27, 2025 at 11:22:58PM +0200, Ilias Apalodimas wrote:
> On Thu, 27 Mar 2025 at 08:12, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Wed, Mar 26, 2025 at 09:28:04AM +0200, Ilias Apalodimas wrote:
> > > Hi Varadarajan
> > >
> > > On Wed, 26 Mar 2025 at 07:47, Varadarajan Narayanan
> > > <quic_varada@quicinc.com> wrote:
> > > >
> > > > If the EFI runtime services pointers are relocated even though
> > > > relocation is skipped, it corrupts some other data resulting in some
> > > > unexpected behaviour.
> > > >
> > > > In this specific case, it overwrote some page table entries resulting in
> > > > the device memory address range's mappings getting removed. Eventually,
> > > > after the completion of efi_runtime_relocate(), when a driver tries to
> > > > access its device's registers it crashes since the mappings are absent.
> > >
> > > How were those page table entries added?
> >
> > initr_caches ->
> >         enable_caches ->
> >                 setup_pgtables (arch/arm/mach-snapdragon/board.c)
> >
> > > The runtime service relocation might have overwritten those now, but
> > > since they are not in protected memory this can happen arbitrarily.
> >
> > To avoid relocating U-Boot, I had OR'ed GD_FLG_SKIP_RELOC to gd->flags
> > in init_sequence_f -> mach_cpu_init(). Hope that is the right place and
> > way to do it.
>
> I'll have a look at the relocation stuff, but off the top of my head,
> I don't remember.
>
> >
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > >  common/board_r.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/common/board_r.c b/common/board_r.c
> > > > index 179259b00de..1dd3b96c2de 100644
> > > > --- a/common/board_r.c
> > > > +++ b/common/board_r.c
> > > > @@ -169,7 +169,8 @@ static int initr_reloc_global_data(void)
> > > >          */
> > > >         efi_save_gd();
> > > >
> > > > -       efi_runtime_relocate(gd->relocaddr, NULL);
> > > > +       if (!(gd->flags & GD_FLG_SKIP_RELOC))
> > > > +               efi_runtime_relocate(gd->relocaddr, NULL);
> > >
> > > Have you tested booting with EFI with this change?
> >
> > Yes, tested this with both GD_FLG_SKIP_RELOC set and not set.
> >
> > Used the command 'bootefi bootmgr' and Linux is able to boot.
>
> Have you tried to call any runtime services -- e.g efival -l will dump
> all the EFI variables

Sorry for the delay. The test setup was busy. My U-boot doesn't seem to
have this command. Not sure if I'm missing some config.

	=> efival -l
	Unknown command 'efival' - try 'help'

However, 'efidebug boot dump' works. Does that suffice?

	=> efidebug boot dump
	Boot0000:
	attributes: A-- (0x00000001)
	  label: scsi 0
	  file_path:
	/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6b00000000000000)/Scsi(0,0)
	  data:
	    00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
	N.....YM....R,Y.
	Boot0001:
	attributes: A-- (0x00000001)
	  label: scsi 1
	  file_path:
	/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6b00000000000000)/Scsi(0,1)
	  data:
	    00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
	N.....YM....R,Y.
	Boot0002:
	attributes: A-- (0x00000001)
	  label: scsi 2
	  file_path:
	/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6b00000000000000)/Scsi(0,2)
	  data:
	    00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
	N.....YM....R,Y.
	Boot0003:
	attributes: A-- (0x00000001)
	  label: scsi 3
	  file_path:
	/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6b00000000000000)/Scsi(0,3)
	  data:
	    00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
	N.....YM....R,Y.
	Boot0004:
	attributes: A-- (0x00000001)
	  label: scsi 4
	  file_path:
	/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6b00000000000000)/Scsi(0,4)
	  data:
	    00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
	N.....YM....R,Y.
	Boot0005:
	attributes: A-- (0x00000001)
	  label: scsi 5
	  file_path:
	/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6b00000000000000)/Scsi(0,5)
	  data:
	    00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
	N.....YM....R,Y.
	Boot0006:
	attributes: A-- (0x00000001)
	  label: scsi 6
	  file_path:
	/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6b00000000000000)/Scsi(0,6)
	  data:
	    00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
	N.....YM....R,Y.
	Boot0007:
	attributes: A-- (0x00000001)
	  label: scsi 7
	  file_path:
	/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,7d00000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,6b00000000000000)/Scsi(0,7)
	  data:
	    00000000: 4e ac 08 81 11 9f 59 4d 85 0e e2 1a 52 2c 59 b2
	N.....YM....R,Y.

Thanks
Varada
