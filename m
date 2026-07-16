Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E14DC44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 02:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C856384D61;
	Thu, 16 Jul 2026 04:12:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AcKHxv+X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NaPTgVPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98B4484D6A; Thu, 16 Jul 2026 04:12:32 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B2180087
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 04:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rahul.pathak@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G0Xs6j1125301
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 02:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FpLK/EkJiqvrsC5kwCLozyIkTfSDZTFoBtC6ehFanno=; b=AcKHxv+XO/hFp/Bt
 ja4kHGJaMROTUldCnh4TybqL+4kIq/8KXzjBHCx3L2eKlAj1/dwEP+k8SGInfswq
 QKCFKXMoQF7wnbWvj0Ha8HqhT7CKyw71mkaVkwZ61DknPeWdhED68lGlzpdBmr24
 +0WJW3Ln+DMYKTdFCvYn+T1CzCQGgJjk+eM/zuWCMf4Ax19Hh3KCqkq88fqe5epk
 vrDRwZdmGbcKYKsGUbZxThgY6asprzdTtynSOum8mxbdj3ZnMMsS5CH5KcyUc+AD
 8QSfQDDCyVRLHFsabsNQMgIk2ADQvqfgjH2DK4ejPeo9eXnBakXm7v3Zaxh4hMtp
 Kdq8FQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7q63g24-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 02:12:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92d1cae5939so852095585a.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 19:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784167948; cv=none;
 d=google.com; s=arc-20260327;
 b=mTRDXbH1+OEssfxkOO93FvYZtDxmdbkW3RIC8SoXSwSyXTcIyvfkoG0FDRModcqnlG
 1XPWP2dE2xloM9+QOXVofWZ19fU6YoPzzTTNXmVtB6crZMJ7viF8aR4tMFZ7i+HZJuRq
 Jr2Vs0E0+FU1NiKOx7s1OSR0S5gUgQ0WyFJjcvHGg/Trec+fKHSegyArfITKxCvaarm4
 leTnYjoWLW3KVWpZKyuNoMACFalPQViQ0vcrcozP4+yRFPOQFcKj88S21BWlzoS0l6gi
 YMqjQa4jDMycL/LSL3s659H9kQ9EvJFCjQkx7ONqYg6+qbOu2u0+x48zPrDNESIBHx5z
 1HRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FpLK/EkJiqvrsC5kwCLozyIkTfSDZTFoBtC6ehFanno=;
 fh=lKF8suJlCFCP9fZ6gCQfGg3jHgNxOnuuzuUhGi7d6ow=;
 b=KTn5Z+c1C2ro2Yy70ElR1bHQ5wmQbrAnWJ65g2NzJk7OgPvCsGNHKgqMDBrDrpqG9C
 /e2SACPQemBn3tuQBCRFY/kr2vACaRMAT3UrackvPI0mLBLzY1GhJfmXOgfGL7uwmMcy
 SpU/C8n4nFM8yb9JP7BODK2nDZb+6L3llMm7OH/o8eLd2oJBT9X6y3+G1qaWdN5zYwmn
 MnDvSwBPmYuxA9zwsjQXgFvOiJBbM62hqjRSTgriJcG7nv/xbfV6PPhb3uHpyLBGwki9
 kEwv4um+wxafEuecKHDvX2WkSt0dKFLJ/NX7l6iRUYSZesEP21EGCLQb54Z6Y93+Cbq7
 FC5g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784167948; x=1784772748; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FpLK/EkJiqvrsC5kwCLozyIkTfSDZTFoBtC6ehFanno=;
 b=NaPTgVPbc2YXgoNKfW30i47241JVDi8cC0Qb7FVZfJ632D9BwrzpiNthKaWF/6B7oy
 chzerpxwfWhjYA2Pk0z7gnxnoxFuuUUdZDWj2KWcCVgMSZdwqpFM0a1bHBbpw2HZUSA3
 0C+ut0lEp7jVnkGqCZtla5/j7zCnG/3oFY9rzp79S/gdek969VRD6rI+wR+hJtLhCLN1
 iatUt19oNO3ReCTBVUhEIEvNsmDI/4pYuiADMyOa5lk2+oSBIwX+xzRPd39gg9gJ/ZEB
 Sdjmcpxs65sKhaiGrT3QFp+HaxhIV8m7Q79iKydLLUeGpRa91uxMeIMCyXjl9SYSRKRB
 hyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784167948; x=1784772748;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FpLK/EkJiqvrsC5kwCLozyIkTfSDZTFoBtC6ehFanno=;
 b=YODXWw8fODVa/MCudxs11aB0wvGVT1vNZ8EmI7cghGMgPlfBHYMZ5ABmaHiX8zFCir
 EEF9XAYn4nxyxGvlMAWsZpKjPcMwBT48uuvUVZtIzaPPMaNIKpzG5DgroSawxQt3R0a7
 Kd7o+VWCzNAZuRTAYqjuwRAvtoBNJBCn1jausWJqVRMU/9+thqoo9y8KG+rWLH5INN3+
 Eu5ME+Ig2yYjO4o3BmIyp1Dq646lyyBvhZlCCmAUIhi8Ypxzbg+qP+Yh4+ErZQdGHw7P
 x8+70jHuV3eKRxzQCnQ2QYKVDxPkUKka/cVntRStS7OQ+uYLHMO1AI7UPlGKwsbQDAdr
 Hcag==
X-Gm-Message-State: AOJu0YzozbZ/P9R4cwJCw/pE5c6jPdmF3ElnSwo9WWkB16sPOxDGlQxF
 BGrCEocnceVTMdKLtvDgwdygNtby3AfF7cYJIF5Gt3RAQVsPunn9IKc6oCU97IUJifOfVF+q1zW
 cgr/RqH6nGuAqVg7lGWJ9THXJ6JHaloQUw1FcxKAGsM7/OwO5XodG2Y9gqJ25fr3eE+n2msu/Ob
 suqjKix/Qblj7+4reEgxIHssrE25tHXBbtLOB0LyY=
X-Gm-Gg: AfdE7cmbWrY7HC7nIGBZ+x1vASATb87PJhqzbBIsNqfocHbU789xR5n/n1dG5kTeRLF
 uswgIGLJXKwfgRVbLCLVIS1A/CoVvE+Zr8bTsxJfZUDVn4+qh5D9nJXmcKIwQV3/kjF0X6ZigPJ
 t+CFmlNT9DS+rB5Pc0w5vch8h5PHgPoXdyvlOuhchaxi26e3gaQl+vyqYEBw==
X-Received: by 2002:a05:620a:171e:b0:92b:67e6:8ab2 with SMTP id
 af79cd13be357-93086be2005mr981293285a.60.1784167947877; 
 Wed, 15 Jul 2026 19:12:27 -0700 (PDT)
X-Received: by 2002:a05:620a:171e:b0:92b:67e6:8ab2 with SMTP id
 af79cd13be357-93086be2005mr981290985a.60.1784167947409; Wed, 15 Jul 2026
 19:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
 <20260709175605.1070755-3-rahul.pathak@oss.qualcomm.com>
 <alZ0/jx7H6RTDXeA@bby-cbu-swbuild03.eng.microchip.com>
In-Reply-To: <alZ0/jx7H6RTDXeA@bby-cbu-swbuild03.eng.microchip.com>
From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 07:42:14 +0530
X-Gm-Features: AUfX_mw4UcSXFXBeF5n2kAtGu4k7LakZfs2KBIYgjkkinFHN4s7-x6Dmyv0leD0
Message-ID: <CAFR3w34FBGdcJYTgooigq_3yhFfPAFwCa9cxxFYC_YpemK_U1w@mail.gmail.com>
Subject: Re: [PATCH 2/3] cmd: Add mpxy command and add RISC-V RPMI driver
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.denx.de, anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAxOSBTYWx0ZWRfX+5PlTIWWlyGN
 PSGJaNFX9cCOV6gnx+nnjeilo2s7W1jTdKz28tiwc2hoNJmlzUxAcejdCaRVc4neWWpLXtqOrc6
 EC06Xx4FF/8wkgovBpj8UV/U+6crIas=
X-Proofpoint-ORIG-GUID: v2WZEQJ-oB0875ZYqZjV_WWfpHEZSQuA
X-Proofpoint-GUID: v2WZEQJ-oB0875ZYqZjV_WWfpHEZSQuA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAxOSBTYWx0ZWRfX/aVp9noHQLm3
 8ogdnl+OJqjmb9KCVOsQTGHgY7WVZcarKHRAh7g5BToSjwEqW7vhdrlDMXkFOdFYqQSedgsIQIC
 0Yut289np8vOK19vSTMgcd4U94q/VVwAtHrhJaKXwz6M5aOmW9X5IYVZeHEAG85WHp1baVTyjRb
 u8Mhd/va7noRFdPn7AeJWeBaVOMyGoLbAm5MgK7JZWnr2XF/3PDksqGBedB46mrULmFEHpknzIC
 NLl4O9WO9vBJ/d2iCQ5wzgZXsySO2Jf89VIsVpODzRZvq1+hGgC4kC8LQoW3/bxRakKJDOGRUQc
 SN14bj2XcxdMdG7JruwQHdZ2b4aycOhDjt7zCgGEta91gHs0EV8IG4ibh4lRWeb91bdDq5dQUQ5
 QcPnXRjOAB1nUtPzaVS53hIBDE7Fb+pfV8eJIAvbhJYKy5BJFvw3Wtj+qPeHXP/T6w6X+XONjAf
 FUwE6HgRUymbO/ZQpEQ==
X-Authority-Analysis: v=2.4 cv=BajoFLt2 c=1 sm=1 tr=0 ts=6a583e0c cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=XYAwZIGsAAAA:8 a=jCGdHkQCF-2j2eI1uIQA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160019
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

On Tue, Jul 14, 2026 at 11:12=E2=80=AFPM Charles Perry
<charles.perry@microchip.com> wrote:
>
> On Thu, Jul 09, 2026 at 11:26:03PM +0530, Rahul Pathak wrote:
> > The mpxy command is an interactive command which uses
> > SBI MPXY interface to interact with supported message
> > protocol through available MPXY channels.
> >
> > The command helps if there is a custom RPMI service
> > group or any other such message protocol implementation
> > and that can be tested in some manner without requiring
> > the S-Mode OS driver support.
>
> Does that mean the "mpxy" command would also work without the driver from
> patch #1 ? If yes, how?

Here I meant S-Mode OS (Linux) mpxy infra/driver
