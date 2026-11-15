Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868A606A332
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xIA8l5em;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mDA+JUbi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eQWCRHY0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D57D406AB;
	Sun, 15 Nov 2026 19:00:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SIbFcVYN-Z9E; Sun, 15 Nov 2026 19:00:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 94D17406E1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769253;
	b=jLjhYbNCmNGzDDC7x4jjQ7KvFPAkXpKZZ0ILsD0av5I+mwBp20j1eEopxD/hOTbLrFYX
	 lC3RtlJYRBtsDg806zJjGqtzrtT8rpUwRjA/vhc5qGR+UWYrR+Ilvq0Dz4JuFgZBSlI0m
	 tsBNY7GF6Qs8Oq9CFXWVsvxIRIS/Xw+SdvZYP7GUDIlvN10RfHuimWtPRRTA0qaPOHjNK
	 z+qHrOx/tHFR1YLAI255WVExqt9Lxjc7GBhPVsHzjn3gHf7hTtbhYmVixeaSifWSrZeoU
	 cxgZKPXuMMA3fYY9LFf4tbA3325QMF308BJsjv9sIaW9e4YLN7V9WUyjgBbaLlM2wQg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769253;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vyQwa+RJjLA9IuO6SP5sTaNlinubDhxDsQeVR63nN2g=;
	b=NwAcZakTFhcVMELBUnSHgSBG/CBIK4nUkJvOvprVUfRX5A71ab3ggsnduVE6VugHVSYz
	 TZd8g7gDScruvFsZUjgze7nIJeBuvgAeukqvKleTMfcTZev6MFUVXXlOYdLdQlzt2/m/r
	 WA7pCg/MO/AEO987HMMjlX/T/e7CRw2/Ni90OQkXgVhsHhXxWgOBDJptBkooA2Eaw1YPT
	 kofEJU5aZ5afl9M16nk9MtxyKCbdtju6kvOqbr2CA7XnYtSZRUeYdfAfQ3Z28etE7vpFR
	 06a8HsG0qgQj93oX35gGZ8Opvo40SyV6XuEdDigfpLjC9Uy4lL2PF/KKavTsHCCSpbA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mDA+JUbi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eQWCRHY0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769253;
	bh=vyQwa+RJjLA9IuO6SP5sTaNlinubDhxDsQeVR63nN2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xIA8l5emy8v5uzOPvTdLcPC+rU3YPqBdK/pG7XGSLfK/2tis6goEqyqmR0Eb7O/K8
	 ZUJo0blAHbTZ8CRytM0aQBGbRcML6SSqwK9dc2IIk/7Xg6x2LcloqGWF641Mwg3Ftu
	 FbzY7rdjJahCPw9PGJDqEao3b5wtmBfvv82ZAxELW9RiJdygzFRZcVXQ98TqikxI2j
	 Lg6MJeFLBGf8Zf72jgnfV8TDFMXa9bVTBbUE/gOyf8W18WTuRXCfW9DgJYn/uokrym
	 /F/yIXImJlYVsWAFnyURMhMl2BePObO930LPlFJoODQI49F0WtKu/bbGrWnWapMKt6
	 77jloaQ4jxjeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94D17406E1;
	Sun, 15 Nov 2026 19:00:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D004B2E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5F20405AE
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0CoLqSB9zTVw for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 18:20:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 30B6040555
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=mDA+JUbi; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eQWCRHY0
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30B6040555
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:36 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFFAk9e2075238
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vyQwa+RJjLA
 9IuO6SP5sTaNlinubDhxDsQeVR63nN2g=; b=mDA+JUbip4hJnGFIrr8tirxxSr2
 OWyYNKoctMwB3ESkPXajzcApTZ3y5mZxAzi6iqfIJXgeS+3Ta5bRhAjhISXQG8nF
 +TEsbXYZ6v9ujbA+8OSWZ7XcpDtwrBjrcp24/9bz8gghbYTUDiyXC2vQdaKU7Bp5
 PY4YJqPj/LcrsEh2PFC8/EsPIicsnpQGIUgKXZumAhhVgriZcdYWf1yHj2o8c0XH
 Ec5tBVQ0zkYdxmF2HJsuWYiSV7jqQ3TlHycY4soO7Vhot5Gqh6SryT7lEevKjbgF
 JtRXFCgdItpbY883OEsZchoPSXsoqyzyP/A+S0YyrmzaA2rh+xHtRNKHUBg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmhkgbn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:36 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso4018367eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794766836; x=1795371636;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vyQwa+RJjLA9IuO6SP5sTaNlinubDhxDsQeVR63nN2g=;
 b=eQWCRHY0l20ccnenr6PaXPb+XkKcYIl6LBVAtXyavejV0kIloi4t3d1JgC+UCm4uzw
 zEQI7ZK7jdrKfjqfDf9ETR1j2xDErBt7dJA4N/KPPvkqydra2EzgRPfARxuWZoM+4qgt
 VXpSyM21u4lhO8etuqWcpLCUSqYsCh/Y9TlJ5zZ2zpIyYVIM45/sMKdowCfXSpBN5vLD
 u9jdqBhYPqLZnFlKC5xORlNv9xtZTF3bClBFTibLQGZzv+I0rlZBWKZfntmKkSlLEZWe
 S3b/GmRxkImKVYjKUE0TGSphZ7PtDNfRlp/d2ToRUVXdbh2VEBWmMryWLZF18eyYkFfO
 4cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794766836; x=1795371636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vyQwa+RJjLA9IuO6SP5sTaNlinubDhxDsQeVR63nN2g=;
 b=0gnD/jQBhhUHH/f8nAVSn9aiaud3uvMRRYv6S0lZ0fXJsQpuFCqJvq2pxxoeVA8/2z
 I3I07WOfBez5rmpdvPshfWGQn/AOOUfHBcH/6BJkhcx07v3HzvooTuEaG2ArRXRXE2CT
 0eqYddqm3b6Svk6+5WnXfgG6hlM81WIwPsAKXpfltpOykbJQnDD6MeaOAYyXkFgRz39V
 Rkreq2hA96fQisOXq40de1jngwkR8PC4hH6DUo7ft0qdbNfDn37r4711ZQ8HH4hAbvRj
 sctQnglpLYtrJ4CMcnL7AVVBMRoTrrc8S4xf2y57sNbIp4LZWgJecX3F/XPsKZlDzRMj
 UotA==
X-Forwarded-Encrypted: i=1;
 AL+hErGLOLfK2uoZaabh7Er63GrNHshs8R2GvIdnl4jTim/w7jkt0T2+0PTG1vR+ShoDjI/YW62kghg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/fDqB507T94h121EXCNsacjVfgvuI7s0UBIlqO+igKjz/YzlKs
 C1W+zPsYjuEp//KmO/2jprUM5ag8bZ20ruTLt5ukN2XAi7q/NcId6dNE2cARtn8CfDpsin7JRNI
 +buvbPZCMw7FVGqkNNKrqNxgqhJqQnxwoSux/bFLbioBsqklGrW8sTfxJDJ8+fZJVVznz/rZTDD
 5IglG6Gw==
X-Gm-Gg: AYBFou05z8oBr5FCzCegSRXMSTSocF/BZLq7JHMR6CX2ukl9OYtZXu1EPqYKHOnZAtA
 z3/qnOFsJOYy0QztALWt2zwnICZmCc9thd65P1Bbv8C9YT/3Ch0E57WbSbZMlDtTktWKfqetScr
 fYoaxkhN4uslq8Y93WWbZ8a1fsBmbbvD8ss3NIjV/yabaCxgVklY2wMjbsQiDxB3v1i642jcKF4
 S79wAzucVqhatEp4zH6a0yJbXlvwEiXQctRvWUju1G8SmTbTJ/zh285zmh3WLIiTwjGXBSlZEmc
 TMwJp/NSqp4EkfsXalXqKky14tEu5rHqfcJJF3gS6QCBJPJH5hS1HK6/cSevuXd8lOYzem9MgqO
 n1fkwtjhCvVbkypxq+DE2NxGF/giuomCM1hMICM4r3ajvkS/EOyOQjCLnhn4mlO7CjnyT+lrn/s
 6B
X-Received: by 2002:a05:693c:80da:b0:37e:9a3b:76a3 with SMTP id
 5a478bee46e88-37e9a3b7e51mr2391528eec.11.1794766835635; 
 Sun, 15 Nov 2026 10:20:35 -0800 (PST)
X-Received: by 2002:a05:693c:80da:b0:37e:9a3b:76a3 with SMTP id
 5a478bee46e88-37e9a3b7e51mr2391493eec.11.1794766835097; 
 Sun, 15 Nov 2026 10:20:35 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm26598663eec.16.2026.11.15.10.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:20:34 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 macpaul.lin@mediatek.com, junhui.liu@pigmoral.tech,
 quentin.schulz@cherry.de, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH 5/6] arm64: dts: qcom: lemans-evk: complete Ethernet
 configuration
Date: Sun, 15 Nov 2026 23:49:35 +0530
Message-Id: <20261115181936.1750625-6-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
References: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _A-6AGenRsiICUyHIl0MHDfznEbh9166
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA3MyBTYWx0ZWRfX9oN058uZSnrU
 0ZQ5wimmtQ8RZ91brt2zt1t/K2fs1QlfdswBRO/5/23cogOiqO2Pa8Z/jYzgxXbonO0MmUMhaQw
 +CPW3SWqO8SjD6iKFvVhN1osqRXqaXc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA3MyBTYWx0ZWRfX4lbsIoZJ7Wou
 jWqnpl+4fAUf0sCC0T8aE54RuUAenAcfn/534STelWqIYPqL0VHSHh2qK2C+8C6JdWc7aD3rwqf
 fKhWiFz7kLnfzl1yVGb/7zMoszrC9N2zKr9kEMFuJwdST0fO/rXYRWaR67czQLvPv8Zahah7jp4
 PZFwoBPwwkq0FFtkLPrLshsKxTh28+XkcWiVSUhq7nbdUSqQIJqrKPtp/aXMPZifLiv/UJ3oRpA
 dUMVmz5D7Zop8M+bdcdWdnwjwFVsIPCL6W8LfTP/oiczJC1O154Z4yByth6vuH4ewRYCNOCtRTH
 5CXlONHO3VFd8dLdmpJ4/5EVwWvOTlQkpHU/lBXSuEYCQRwt1d1hUadAV8k5ZHUYB7bp+PZUIz5
 NEyukkVUJx/RUukhKvwrKEiX0wKQ3mlbOzAddQEgSbN5bilNLoG1YAhBTGRqUo1sMBVdeGnvOay
 9kmLdS4Gf13mlMzd7qQ==
X-Authority-Analysis: v=2.4 cv=e/2T2qp/ c=1 sm=1 tr=0 ts=6af9f7f4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=wrzHiB9VLAWrdRu-554A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: _A-6AGenRsiICUyHIl0MHDfznEbh9166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150073
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:41 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

The Lemans EVK Ethernet port is wired for 2500BASE-X operation and the
SGMII SerDes requires the L4A regulator for its 0.9 V analog supply.

Set the maximum Ethernet speed to 2.5Gbps and describe the missing
SerDes supply.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
 dts/upstream/src/arm64/qcom/lemans-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/dts/upstream/src/arm64/qcom/lemans-evk.dts b/dts/upstream/src/arm64/qcom/lemans-evk.dts
index a45485b54a5..5775e558f11 100644
--- a/dts/upstream/src/arm64/qcom/lemans-evk.dts
+++ b/dts/upstream/src/arm64/qcom/lemans-evk.dts
@@ -522,6 +522,7 @@
 &ethernet0 {
 	phy-handle = <&hsgmii_phy0>;
 	phy-mode = "2500base-x";
+	max-speed = <2500>;
 
 	pinctrl-0 = <&ethernet0_default>;
 	pinctrl-names = "default";
@@ -979,6 +980,7 @@
 
 &serdes0 {
 	phy-supply = <&vreg_l5a>;
+	vdda-0p9-supply = <&vreg_l4a>;
 
 	status = "okay";
 };
-- 
2.34.1

