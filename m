Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A910CC43458
	for <u-boot@archiver.kernel.org>; Fri,  3 Jul 2026 17:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18337849F0;
	Fri,  3 Jul 2026 19:26:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cXcXmS6Z";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iS3WK3LW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F91484A63; Fri,  3 Jul 2026 19:26:53 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27CC0849BA
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 19:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIsGO498335
 for <u-boot@lists.denx.de>; Fri, 3 Jul 2026 17:26:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=fhiJSgsk2oSTwhCPd1EyteIy/lUolRIvbm7
 JNAjcKZU=; b=cXcXmS6Zisj4s6Rj7tK9pt0SvV8R0eYnlTyFe9re9x0HSLpZ8KE
 bo4DR5NCLn4Wl8iEp8U9Ktldm+yM56l7i7Wau4Segi0DHjxBi6BuTc0bVxzjaY1E
 0VX3nOhsWpxJtzfUaty1ioHivxz/p/Lep4zwzhYSgXJ7JN95XrwKVKk9S1c/J9pd
 oFV1ibYOf2Fi8iZM+Rk8EASgcAIn5ZQm1YoHahpA/yWBol0VdsStPVVXt14OHg/y
 HbaOhYjrWZ6indQ4ul94oDMY9CjhXy+weOSGylFJwtfse1EXnhrDdDYKmj6g+RwP
 u1OG34Tc7yq4eS6/BzAW1x5Ai9MVtqNT+4g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f65qck2u7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 17:26:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3811279d51aso1445148a91.1
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783099609; x=1783704409; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fhiJSgsk2oSTwhCPd1EyteIy/lUolRIvbm7JNAjcKZU=;
 b=iS3WK3LWIhkkFQcptlaaGNFMeZpjS/AdgctrTtwYhLT8kyU4UwX7ETFGOXGRv0iTNm
 Qo3PupiSmqiKwWX215pvZxn6+WAUocLswC9Qfbeq9d6yhiIZ6sGldyua0kK/5/kkHvhU
 9P87MhFBLbRZrIur/UocY0qfNJtJrymooUcOB7eprNzAv99h2Vp23Ryo15Qmvw4KxwXA
 Xpxtl9cMcT+UY5+G+9jSvfmbuHutKvxWoNfKItNZGt8biX0xEI7BRuj1hsF3vV6Q7v+2
 iZVwZEBdbXEa9BB5lhI8me3TClA6EAEP0EaffWLD9UgZwzG7P0eH2HWSci+3/NyWelVt
 qvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783099609; x=1783704409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fhiJSgsk2oSTwhCPd1EyteIy/lUolRIvbm7JNAjcKZU=;
 b=NPILhXQ2Xd2cGEbuE0umpaRLr4oPFS6dwvdLuCA9XEakotQF39fCDZkusNim7brWo2
 Te/HzBF2/4yo/ZoaKr5R0alciu0dxmnE3Wx67N9NiFrg/peW9YfayXCJd4BeB9iICpGV
 VtHt84ZDmCm/kMRCZ1r0qxOQpgC4ok2EEs5ruklbcIJfD5tM2/3WSfcNOvRSunNC6q6P
 vI/SpZ+aOwPlVkQj66OIQBZxmASlcXk5lfOmqaFB1ZGoj1sFlAH0Zzq12qGxMaHiabmp
 8SfcWE63uaVv16h4E9gtRNJOcNU1gdrdwcJchkN2lhuAu3fddgJaxU7tCiaL8YpDtPMe
 K8ag==
X-Forwarded-Encrypted: i=1;
 AHgh+Roe9u+n/cjNk7FJPg6B1Inpb+kOETMzO6rI4sfx7kemGGOk3S35OUiIlhghXKg9da/zNgqCtZk=@lists.denx.de
X-Gm-Message-State: AOJu0YyiofyzbUPjUtV7IFIXOEZ7C2YCjC9LQhDu/ZU7miOXM/49pEmE
 WjNmDB8XxLsEt/X1VztMnKNzbQMK4EeDoQ2X2Vy9xxYEFH/sgRBy0CaqTN4TOC3XgdDWHepmoUO
 KCCqL7zN+oQP++y0X7XYVhrDdvo4iFuX4VDmjyOewckMBDulgRn2jIxGq
X-Gm-Gg: AfdE7cnmPryL92BuAiYdGTzdovVfgop9nhP8l+WPjNd3o+OeAqwKwv4MLxCtqeqnEY2
 CK521HlmukDfScPDNqsTzKprmBBhAKWoyDnH46RsYiny4EjewYZ79y+mSnPc+M5rK0VG1YdNkd0
 bQB8DFWOjV7RU4cpE5ojp+5fSh/qGdNgwbTN6q2C1UkIdYX7jDQ4Hc0SAPXp8DcxQJYLRfe6yk7
 UGiTWMrgDN3pf/cc2Z3TmuSomg7eRoDjh68CrN8eC0jftEJ+PbBaisJcZfdVclaQmp2pXxuaIFd
 sv1ioSxME1m6jRaDx3OxAAP9RxtFC84aPhugg+HVs+ahogakGyCqDq5Q2ayEMGLZzeSdcD1bsat
 L3Q9c8/Ink+xSLNWATu+TnDoYYfWNz3SKNuPXnlYr/PgK/GxadJmPU9zalT7frGlbCeag4lRm5s
 F82peRkmAbX8WQR0ZL4VSQIsH29oGhpQ==
X-Received: by 2002:a17:90b:4c90:b0:37f:9ce1:cda8 with SMTP id
 98e67ed59e1d1-3829f9e9fe5mr354394a91.30.1783099608460; 
 Fri, 03 Jul 2026 10:26:48 -0700 (PDT)
X-Received: by 2002:a17:90b:4c90:b0:37f:9ce1:cda8 with SMTP id
 98e67ed59e1d1-3829f9e9fe5mr354358a91.30.1783099607927; 
 Fri, 03 Jul 2026 10:26:47 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b813d37sm23489561eec.10.2026.07.03.10.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 10:26:47 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 sjg@chromium.org, aswin.murugan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v4 0/3] mach-snapdragon: Add early EL2 hypervisor switch
 support
Date: Fri,  3 Jul 2026 22:56:31 +0530
Message-Id: <20260703172634.140515-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eNprtSMCrt4ne42OstPVrFzDP4meKqMB
X-Authority-Analysis: v=2.4 cv=Bb7oFLt2 c=1 sm=1 tr=0 ts=6a47f0d9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8S4Ko0p2hYbYe84NMw8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: eNprtSMCrt4ne42OstPVrFzDP4meKqMB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfX6+Y4yFMkZMk4
 BY2w4cudKBxIs+Isc+6eUx465BVlrH0b8R7ndDdH7GseuR1fMfGN7xgpfWorDqCzQ+l8uqj8xjD
 GEDFhkB4Y8GkCGJTukLOtaFp12RBUNpMklZVhwv1uMkeBDk2pywCnK0t/8jE1g3IEycMTaRaWCK
 U5qBMNW2w16TRfv4GaEn6y4eyq+sG9Ieym2FhA0e5p5CJGc2e7lBuTkRqKFXopbOcJCIqcnWVA2
 ZX8bc0qHdGJY3/GsSJ5+gXiBBrdoP8aXJJu6UkukoN9sT9uSJOZlc/zsEuNQNQR5OYZ7fBznlRC
 N5UfJ6tcuXxuGg3nRuO+AxNxWXs0e9+iq0hFbg8vfpiY+sk+1Y1nT1NazyI5XxhjNOd5c8Z8sI+
 CqAPTzKPd68SoBCNxtc9r8X/lGAR9TrX3MKPOZryUX/Mon3D5pyGHbtgSFITPqnPGEaQadazF77
 8DUggFn1pEJ50bc4BWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3MyBTYWx0ZWRfXwULn/M/HS3o8
 tCl4phH/vw0YNiBcgexLSkxBZYtyDsmn7qCPwQCzM/i5XaWivJJj81ltuih5fiBcQ/rK7YiQopg
 87FlvgOVqWDVd/uNKUvbKOiFNXCqVic=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030173
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

This series adds support for exiting Gunyah hypervisor and switching to
EL2 during early boot on Qualcomm Dragonwing family platforms. This
enables U-Boot to run at EL2, which is required for supporting
hypervisors that need EL2 privilege level.

- Adds early boot0.h infrastructure to exit Gunyah via TrustZone SMC
- Creates a reusable config fragment for easy platform enablement
- Enables the feature on QCS9100 platform

This series is based on the boot0.h infrastructure from:
[1] https://lore.kernel.org/all/20260521-qcom_spl-v9-4-c108ebe8ff4e@seznam.cz/

Changes in v4:
- Updated Kconfig and gunyah_exit_boot0.h header comments for better clarity on platform support
- Split config changes into reusable fragment and qcs9100 platform enablement
Link to v3: https://lore.kernel.org/u-boot/20260515130934.388894-1-aswin.murugan@oss.qualcomm.com/

Change in v3:
- Corrected the logic to accurately detect the current Exception Level (EL)
  and fuction properly when U-Boot enters either EL2 or EL1.
Link to v2: https://lore.kernel.org/u-boot/20260515065632.90772-1-aswin.murugan@oss.qualcomm.com/

Change in v2:
- EL2 switch is made at early stage instead of doing at the very last stage in
  the previous version
- This change is based on the patch [1]
Link to v1: https://lore.kernel.org/u-boot/20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com/

Aswin Murugan (3):
  mach-snapdragon: Add early EL2 hypervisor switch support
  configs: qualcomm: Add Gunyah exit config fragment
  configs: qcom_qcs9100: Enable Gunyah exit support

 arch/arm/mach-snapdragon/Kconfig              |  8 +++++
 arch/arm/mach-snapdragon/include/mach/boot0.h |  3 ++
 .../include/mach/gunyah_exit_boot0.h          | 36 +++++++++++++++++++
 board/qualcomm/exit-gunyah.config             |  4 +++
 configs/qcom_qcs9100_defconfig                |  1 +
 5 files changed, 52 insertions(+)
 create mode 100644 arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
 create mode 100644 board/qualcomm/exit-gunyah.config

-- 
2.34.1

