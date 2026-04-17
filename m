Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1454AF43689
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 09:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7589484223;
	Fri, 17 Apr 2026 11:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ia5lZQ7e";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JpTCufQX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAB984228; Fri, 17 Apr 2026 11:39:39 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6309783BC8
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 11:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63H7eZ7k4018418
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 09:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=mOW9GD5wW5sXnBiy/HCmeN7udjAdNFhuyVO
 hGfy3xrs=; b=Ia5lZQ7eFRCsBhRocn4HiRVczF6rlzJgfdLuH1ed5uYoZZAk4Sn
 ejumRj62lKMflziCSGHHwEXROfJfoDLilkOwLssWdutjWFtx0PG31jUbspwV/e1a
 d5YZhEQJPWUiiLMb8hIeEXKpaTusooZ4j7xi2B/smC3dGAp+V/DoQhEhrgDVwc+F
 IAnvqQy9juxOVYy7vGfwmHv42Q40piaOLj+JOx04Hwn7R4+rdlgBYfA/EUZ/ClIm
 Qcf4LL+EUGKYUpuoTXMiZwA2QnOKrslF/HMMgnHcp47F01oWuEkRcpBJXALOCNna
 sftivjrru44HfouXtH+KTXgus0ZjCQNiVUQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dk11rbr5x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 09:39:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c76bb22a8ceso699492a12.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776418775; x=1777023575; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mOW9GD5wW5sXnBiy/HCmeN7udjAdNFhuyVOhGfy3xrs=;
 b=JpTCufQXmK6bZEXLli0AYfKLZt0zW0LKscHFOOqqKsBV0VtSgBYtdyyRxV3yupMEcV
 9SDme6w+Itju5+TYBTdklCxLVzZeJ5+iPxYlbnnxJRpf/p1JEpRyyUjJ2/n+YxVx54Av
 E2QOIZZq56b3WKWXMshyBnu2xtJBaukU/r9UMTJb2Ek2+Ovr+/OaDDsxqO6FPm7XcW4M
 mjkUYxkR+otG9wRJij0pjDiSLUW7glFBUoL7f8aAEjF9b2k8M6Ncqef7rDIYRpAv4/Nm
 jvQota+1dnSYTepks3D15E4TfDw6og0Z8R1j82WpVELcBKtYzNBsh5+Hejh7fLqj7ysM
 BiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776418775; x=1777023575;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mOW9GD5wW5sXnBiy/HCmeN7udjAdNFhuyVOhGfy3xrs=;
 b=OzSrtir6mZzj3NANdkOAolBVPUfiQKq5UrYIkR22iXYeXtrwvFV43E1bJ4/Lgk+MFx
 yKIP6D3ALC3aEOKfaMGe+k+NcAQeeRyWUzLj52PvyUcvih4UKa460uHSrWQ8NJP6CEOk
 PCw3jZfQpeJJutOBOwHD6HSyOIY5/+7TU/LEp124skblzn8Z0+kQCipIeJKxSL76ic0h
 8GFw2IvJE+Z1clJpQJO95aE/yQlmJOklrkXkO+BmNOFc5gPk2m2UJ9ziWoCmNtlqE2M6
 KJ1E4w8kqf6065LUrTOguarO8GSvPBgpuNek0AQikNgMp05vwwGBcswj+1MUt39QQfh4
 O5xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ81/xzZuGBiFsdypEgP7mhZX63BZUieQnjoLNM861VwSY/c64WmRpW7IUG3rPkxGLOdzDsusxg=@lists.denx.de
X-Gm-Message-State: AOJu0YxSyfzQ3hgSgL1rM8i78ZfixijXx0o0lkXGQKVl88Ki9SjIViUZ
 77Dqynz2q3e9MzN5S9CrMK04rK+KjuH25r8pxiy7qYijQ26aB+QFggD9UY2dd3LbM0gWWdm6HjY
 Ryw/Sl500kaa+Dv36e4OY9aUXwWJK1k59ngtsm0l9vfBnIttW2WiXGilL
X-Gm-Gg: AeBDiess56p/MYn3VZ49W5MSnQqRlURRIviJu/sddDmUf5MZnaLe+qG4yHTAPGpI6Gt
 Iofu0cDTDxiKXNAAa7vLZz3vXj75aLwiprEjp9vbaB5+imdv9aGU49YOBNmi+fJ5FrVtMrYFD0a
 mh6ZLJ0KWdXmkorqaMF+WbaZFS2QHyGNbOOmigGLX7wUvnvitLJS+rmiFl3PFjxFn/y/gC9gjFM
 ON8sFHi/V5m8JIQxSza2KBjFgjr65FoNzpOQ/FEGAhRi3JVrZXVjEUC3vaOkkUWCkc8orRDogda
 TAMYirtVmxbYxpl0JrtcinODkXryVFpoHUtFUptAQza+DlzYef45iAAaT3C8ccajoM1UAzKBmBt
 SwsxFDcYuvOn/OCFw+IcVl8tBhuz7JMGZ04fcA/2W30/sRf6GN/Og7ONio5VjsY9qD7hJeSg6pr
 U00SUQ05V3ECKGdC10eId1LRqy3Hh4PjkdnA+auagCnjzN4qQwWQ4=
X-Received: by 2002:a05:6a00:3017:b0:82f:390a:69c7 with SMTP id
 d2e1a72fcca58-82f8c92c6f9mr2141528b3a.33.1776418774627; 
 Fri, 17 Apr 2026 02:39:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:3017:b0:82f:390a:69c7 with SMTP id
 d2e1a72fcca58-82f8c92c6f9mr2141502b3a.33.1776418774203; 
 Fri, 17 Apr 2026 02:39:34 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebb3fa2sm1371612b3a.29.2026.04.17.02.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:39:33 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, quic_varada@quicinc.com,
 balaji.selvanathan@oss.qualcomm.com, dlechner@baylibre.com,
 aswin.murugan@oss.qualcomm.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/1] qcom: Rename QCS9100 defconfig to Lemans defconfig
Date: Fri, 17 Apr 2026 15:09:23 +0530
Message-Id: <20260417093924.3357296-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDA5NSBTYWx0ZWRfX5nzzuzbnQjbi
 /+TpBvffXwdPBGwNFlny+3lqvdO7DPpgeBLlthZDak6iIjnS7Ep/2y7Mezc+IpiCOd/KFDkHRP0
 CjU64sTDCuLqC53BRDcaAVDTeSAENLBschMVRmw3p/OVtkge+epVX4RSnLW/cbNeraURkm5RLuh
 PHC4a6PPQxQVKHWVLADiXls02dDPiNW7ZYiIfYRM3JLBcUnYSmM0RQNka9JqlKyFr70c8WQEV3d
 LR6Lnv+aesi0JbSy8HVfrwc1NjBukUM2kbj7NZORlo8p3svz6qbesiTcHcsk+oA4lEo92u1Wum3
 xza82cyNzgThkzb6zyyo2pl1+i/1hmiTCfRYh1P52EhqSs25Sbh3dULNc/0EXXsVlo30wnlVa6g
 fNJo2G56HAmdHZgvLr6d5HZcqD8YNzVzMvTobr+qmCu277SlCr0d27G28FfBk+sLzYXPYNw5n5x
 uqVVhP+V8is3VJ24Uow==
X-Authority-Analysis: v=2.4 cv=ZPznX37b c=1 sm=1 tr=0 ts=69e1ffd7 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=yIzvdVzmk4UeBoQm5zIA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: 6Ev9xttvei-YtSPUibONyw5PHT8rQiil
X-Proofpoint-GUID: 6Ev9xttvei-YtSPUibONyw5PHT8rQiil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_04,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170095
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

This patch renames the existing qcom_qcs9100_defconfig to
qcom_lemans_defconfig and updates the defconfig to select the
Lemans EVK device tree instead of the QCS9100 Ride R3 DTS.

This change depends on the patch [1], which introduces the Lemans EVK
override DTS

[1] https://lore.kernel.org/u-boot/20260415052659.507928-1-sumit.garg@kernel.org/

Aswin Murugan (1):
  configs: Rename qcs9100 defconfig to lemans defconfig

 configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename configs/{qcom_qcs9100_defconfig => qcom_lemans_defconfig} (91%)

-- 
2.34.1

