Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8308CA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 12:02:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6C8C80E11;
	Mon, 28 Sep 2026 12:02:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JPizTkCGS24P; Mon, 28 Sep 2026 12:02:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9E54680E12
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790596970;
	b=aAw8h5jNTQAvEJMdYTsZWDN3qX9edbpITh3M+kjtnxOgRzxDDs6u0h7bHoeVG9Xn6OBg
	 b63k9IwSWAB5NJcinmlbZWxuVOzyboh4c8eSlNBZEUidxxGhpP6f/JxXTqq1rsG7JAjRn
	 WjQpwOAfKGyzXgO6h5nK/WOyQnCWgLsHUd1SvhyNO+HBb9WhBixIN81jAfIR1K4ANCR/K
	 Xyi4JANKuAQHVfXXruFmoDfEWGl3chujhmp0TzM1XnE9juqSJYHLLQRpYpKmczG08Nr4i
	 x7JcoxsCw+v5UCVVj2kPF84JqfpyDdNquQtgjXQRyNXHCOO79UzbttN5GJ8616LjAKg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790596970;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=vTotgUItPcleNQ80bJc+jpApS1tthVlI71MYHD9JUZg=;
	b=NJZxvpfMsgtiWEf2kQqkGeZtDM56yDUmGo/ovvYWs8FtCLKuJuaDIWo4fIQ/HM1wMrBP
	 58WhmaPZPG20+XQ3vp1HPNCLDF/xn7TTgFgtb9n8fo1PTU84q3Zrtlkc1GnbhPq+MxRsl
	 FfCs6CMLa1aGroOTBZqzGMokoLL3VmDKgJUjO7NZ1KfXOHcVKtrmBb/0rbeTuZhTaiEZU
	 EmZzA3wj82t1TGUCVkQ9mDXmSCqK3csxnjJvatf9qRRlfVFtD4DYFu8UnN1b3uqBMA4DE
	 B2Tg8XuwfxghsXYQMbNqdapCmViG9kd4LX0YCCCu/iyhXAgfLqoxvdQV5cNywS3HKQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790596970;
	bh=vTotgUItPcleNQ80bJc+jpApS1tthVlI71MYHD9JUZg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=copWrsjjOt3ybPy29EjTXHvTLB/+HsCwHophPyo1aFEr/oo/FSTICUG+f3hPVwHvq
	 RzdHiusn597M9k/6dM2ntyXtc/RARHn/MmC313rMEnGMMpx7pY9dE/eGzDair6IyBP
	 J+66Pc5gcOCY0dMb3P33J/XypJqEiLY0uQaU/hpUxuHURYcasmDA+qObOqYe/j5Mjf
	 qPeOqy0i+AWFrgesWwOcolVZD6qGZ/y2MK9UngX7UXiSh1KWw9y/yvWe0gHA2jQphR
	 F9O8HlgUi+lrx6OBWhi3gz+8flizIQ9uWRE/8fRR3fi0dvpShq46ZDE3WzkaLI/M6/
	 AtjlFRSfFDLCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E54680E12;
	Mon, 28 Sep 2026 12:02:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 875A82B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 795BB404A2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 39tlevvtcmQp for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 12:02:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 839BD40475
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790596967;
 b=jRvSBS9+X0mWR+zfPfO8Bj91EXsHf40t0Wkobi62TmFybBbz9WKuKlqVApFNFidmfLAB
 3nwJidFRAoNpU4XaINiWXU0WNcnNypcevrqzRxPEI7XyIUv6Oi7WQ8rX2ofwGWP66bxoi
 dPza7yCIHw6IKbg6VtocBjeqmcO1XTZcl443Ohk+eVKlIzn2Y7G/p/jnGF1Xa1zwBPZJv
 BAIbc/KzQ1rFycAEHnv8GbN/UR3lcs/S7nWGRn/5uCYj9DPkl2rSDNaxrLx12QVppD4XL
 wwx2sSEL7gmZKdxiTYq2rv414MvBhcyS+Mvq59Dug1WSuUEJNnug60ANPiP95O8xaog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790596967;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=vTotgUItPcleNQ80bJc+jpApS1tthVlI71MYHD9JUZg=;
 b=C8G070doZweTPbBqyc9sVK/7XYkkWSFWjJle2O9O8opgTZRchnYed5VwWs7TzlMi3Cpf
 dgJJVIAXEhgYVwgtl0kkhy/+jFXMiz3jQO5kAjGgF7mEQfclNWAaV0LT2Elx1sE2iUHnF
 U/M58Lpx2oTmdLs4ab1PwU4ow5P48QHtTLUjAqQKKzAqp/rCJm6UFNMQHc9zxIrN6xD22
 5l4HwEaKALuPE01r0QuGjcQx4Tx+tcSRd7fKk6DvxoTtOY28sLSfGcdPxQoTsBmlzaOOC
 pww31owVSMkZeHZZKA2UCkyw7OjzXHTI/RwC+HTFrYVISb1vgERgktHskiahqaBIvBQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="J/j3FblH"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kewMiNDI; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=J/j3FblH; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kewMiNDI
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 839BD40475
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:46 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SBANqg2294784
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vTotgUItPcl
 eNQ80bJc+jpApS1tthVlI71MYHD9JUZg=; b=J/j3FblHcdg7+9lx8+BWLZdBD1W
 tMD2hvBCRLt0wUTvEZNQDBc/7x9lkYRYyQkJZcEs84EORm6nYdcQLWHxHTqCNjnT
 x1n/FnCQvb2479l+a6T2NcBY8aAJsE0/8Dg2+j6ErOwPCeHvnRW+mrWE9NehOEaf
 X1gUNgJcEqTxYd2Wgr48OpCuzVbrS5rpDohF2o3eL2WkWsvf+kOo9bG9aZrQQBVf
 QAxUM7fht0VvUZxzxpQfS5IlFj/QeisU5tuMdV1LRykCdGrmFsFmdDFr+rnGCgy2
 1YrlY3209kRTYyUyTfA+zHvePyyaMbdj6oEo5hjkhPs+kv2ycJPyWveOu5g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubhdqv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 12:02:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34344599f01so3452562eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790596965; x=1791201765;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vTotgUItPcleNQ80bJc+jpApS1tthVlI71MYHD9JUZg=;
 b=kewMiNDIF7RoW/ERo7zTMT3us6DS6xzBBZc5ahRy04QPiedkegsqnH6dlyJ1XuuYin
 +6eX8OFqoBXOiRh9ncToTKC08U7qLEIEe+msL8EM/MPao9NebZvAEvXxH0wb+m7RTes7
 ioWGUe9Cmv/oQyFhphyvcKYWWoO7V7mskYdcyae+xuU0Z2IXDslog0HCV7T3xcUrvAR1
 BrCBU85uR+sAWOET1i3hKqQJxzMsz+mMpO6tjPi/R+ybta/cVqJ8F11+a0D3UI0T5293
 0OpxSl5ufhVV2twNIkkrbpZKATlQjJKBWnFC+FxWmjyqc/FPI7sGKJITlgv84adsVhU0
 crig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790596965; x=1791201765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vTotgUItPcleNQ80bJc+jpApS1tthVlI71MYHD9JUZg=;
 b=23z/zs3mJG7+VD+Q7B1jR0ndvzbodJQwY7LnJNfRCivhh6iguVrZe2f7/LdtcNzE4R
 YO6bDwRVygNxIwK34J1LyWyy7lQE2HnwT/M69BHv+ziyMYrlFR/3Ed+joeukVRdCbpyG
 9Wab4is6tkxXe2m4sWAI/TQhzsDqFO+eFLmuin4VFDz2dwqB9nKMQaoF1H26ycEjOzz3
 sg4T+C/uA95faL5/ro9LSKa8ouZ68kIwFwOP3UTqarAVRx5nylwYDnqULKPUyGlC7vHi
 yr2mJWzlLuL1Dc7AM1dvCyQGcWFERtrqzQAly+U2/Nw2lpuWiBpUyct8Zzyq8rTQriLs
 dd/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrF68uScCgolDFl693oMaN0yuPJ8bsLvedu4nEBN362ogAEzR7JcHB+GvvhN2tn9oOZ1Fyzvs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIPo7p+W7RuDVSpi6Vb5TM0JYuKLpCzGkIVYGpAUKFmYIa+roqf
 f/MdN6ajSmJDET84cYHch7ywlVnkkWFlEdfODz3zuVu5m0NrT2yV/icaKFfeoXM974XXKIjxz5y
 HertjH5pT53JvOZxbZA+CdsUnHRemZq32tLDTzYHxdQu3oDmnspfm6C4LR+DYjKt6NGolON8=
X-Gm-Gg: AYBFou068dwRNTqVZ9YBpOUJSn0l6wCsFGGdrAD/cJutSrK4VsZYYsOXyABcx6aI4aT
 E+Rt9d9Kr+iU1eA/0iehsTZGWfwGqD7TtjFqpxpGgclN6vNeKTY0mcsaoGW627MlkdH/o6zOR8W
 EVaHF8EnqmQcWosIeE4iII16hLi1z5BPoYK4Uo6Wdgp53biwPzCxDLLjs/8DIPladFwhqdJWVtI
 p2pxr3SEszdvpLesu9xTNrQcowHvkeajq1zyWY0qazF31vVoDxpOUOjHj00exwtH0st/mCgoWb3
 jqHzj7exEGDFP8eK3t5B1vYCya+Zm3viLs2tgSzmot3ovxtfmvX1HmgR/OrS+oUyaQJ3r/Ep/4g
 /LJWXniqWu04eVb2qqN6ZnAQeZI1b2zxGkGKkdDTKIp0UJKi2qBVaRimq8LxkD7xoI/38JbxMI3
 LcZh5W+TIiPDCiPJv46g==
X-Received: by 2002:a05:693c:26c9:b0:341:1823:6a50 with SMTP id
 5a478bee46e88-34270ac5e2bmr7655613eec.15.1790596964570; 
 Mon, 28 Sep 2026 05:02:44 -0700 (PDT)
X-Received: by 2002:a05:693c:26c9:b0:341:1823:6a50 with SMTP id
 5a478bee46e88-34270ac5e2bmr7655584eec.15.1790596963774; 
 Mon, 28 Sep 2026 05:02:43 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144b4ae50sm28658382eec.17.2026.09.28.05.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:02:43 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, lukma@denx.de,
 aswin.murugan@oss.qualcomm.com, nathbappai@gmail.com,
 Michael.Srba@seznam.cz, luca.weiss@fairphone.com,
 nikroks@mainlining.org, jbx6244@gmail.com,
 krzysztof.kozlowski@oss.qualcomm.com,
 bartosz.golaszewski@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v2 4/9] clk: qcom: add SEGCC driver for nord
Date: Mon, 28 Sep 2026 17:32:04 +0530
Message-Id: <20260928120209.1064781-5-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
References: <20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WVbKZsXZo51Uaue_PBSXHknhHd-WzwxA
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba5766 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=eG301sXog4t-Lp-OmasA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: WVbKZsXZo51Uaue_PBSXHknhHd-WzwxA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX8wXW4+garhiw
 KDLlE4+qqikbaIIl6cn1jhVvpgfbUJ1gISi62nU8Radj4XUDbZGg29xRaPZhUXC2NHCZ63+IQAG
 2mLq815czq6hxD0CSs8J0qD3gYFK8bllEQHf+iXSeYGSTOn/ugus0E4DPjyP8y1MVQILhb4WMJT
 /XlVkpbybCmuHKOQ+Y7LNbMFjJ2JxqyCqPufxIx0KL9tWdxWvdtMlbToChqduwwAe+6FRWE3m+M
 VTOwnJ8gcbaHtjAACeHaxA4+pMDHik+XXlCVW38NxF9eBZn2pUSxVKZ7AjEsgFGmJbdDI9y18k8
 NFTZSd2c9SvJZgPO+uZqWMk5LgMgfcRDYXE38mAjhe8vS2wAKgCboEvR+Ct98gKZ7cgk3Ka8Fxb
 o+aMnxM4/cKZ+Ejw1n9/1b32vl23g2csBpBE52WImsBOgyuwCc0oNcZuv+xYkWf5GiWheU/blaP
 WU1nRbItCmWDvortpnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NyBTYWx0ZWRfX9VESPrAWxpma
 3sHpPEw26eNuql+KYrwHPULjt48sSMzGnjp5UQnCQ4or2nIK0MaDJ32eyGgW77g6L85ly3zZQPV
 fcjmFiqHcaz93fbgwibU7LXgLiKrwZc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280047
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add support for the nord SE Global Clock Controller (SEGCC).

Implement the qcom,nord-segcc driver to provide clocks, resets and
power domains required by nord peripherals during boot.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig            |   9 ++
 drivers/clk/qcom/Makefile           |   1 +
 drivers/clk/qcom/clock-nord-segcc.c | 137 ++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-segcc.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 4dff30928ca..c10bb8186e9 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -72,6 +72,15 @@ config CLK_QCOM_NORD_NEGCC
 	  UFS, USB, and QUPv3 clocks and resets exposed by the NEGCC
 	  hardware block.
 
+config CLK_QCOM_NORD_SEGCC
+	bool "Qualcomm Nord SEGCC"
+	select CLK_QCOM
+	help
+	  Say Y here to enable support for the South-East Global Clock
+	  Controller on the Snapdragon Nord SoC. This driver supports the
+	  EMAC and QUPv3 clocks and resets exposed by the SEGCC hardware
+	  block.
+
 config CLK_QCOM_QCM2290
 	bool "Qualcomm QCM2290 GCC"
 	select CLK_QCOM
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 03bf25cbcc2..e7c6e5fe35b 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
 obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_NORD_NEGCC) += clock-nord-negcc.o
+obj-$(CONFIG_CLK_QCOM_NORD_SEGCC) += clock-nord-segcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-segcc.c b/drivers/clk/qcom/clock-nord-segcc.c
new file mode 100644
index 00000000000..53a8732c646
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-segcc.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bug.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-segcc.h>
+#include "clock-qcom.h"
+
+#define SE_GCC_QUPV3_WRAP0_S4_CLK_CMD_RCGR	0x2665c
+
+static ulong nord_segcc_set_rate(struct clk *clk, ulong rate)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	if (clk->id < priv->data->num_clks)
+		debug("%s: %s, requested rate=%ld\n", __func__,
+		      priv->data->clks[clk->id].name, rate);
+
+	switch (clk->id) {
+	case SE_GCC_QUPV3_WRAP0_S4_CLK:
+		WARN(rate != 14745600,
+		     "Unexpected rate for SE_GCC_QUPV3_WRAP0_S4_CLK: %lu\n", rate);
+		clk_rcg_set_rate_mnd(priv->base, SE_GCC_QUPV3_WRAP0_S4_CLK_CMD_RCGR,
+				     1, 384, 15625, CFG_CLK_SRC_GPLL0, 16);
+		return rate;
+	default:
+		return 0;
+	}
+}
+
+static const struct gate_clk nord_segcc_clks[] = {
+	GATE_CLK_POLLED(SE_GCC_EMAC0_AXI_CLK,           0x2401c, BIT(0),  0x2401c),
+	GATE_CLK_POLLED(SE_GCC_EMAC1_AXI_CLK,           0x2501c, BIT(0),  0x2501c),
+	GATE_CLK_POLLED(SE_GCC_MMU_2_TCU_VOTE_CLK,      0x57040, BIT(0),  0x57040),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x57000, BIT(15), 0x26020),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_CORE_CLK,    0x57000, BIT(14), 0x2600c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_M_AHB_CLK,   0x57000, BIT(12), 0x26004),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S0_CLK,      0x57000, BIT(16), 0x2615c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S1_CLK,      0x57000, BIT(17), 0x26298),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S2_CLK,      0x57000, BIT(18), 0x263d4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S3_CLK,      0x57000, BIT(19), 0x26510),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S4_CLK,      0x57000, BIT(20), 0x2664c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S5_CLK,      0x57000, BIT(21), 0x26788),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S6_CLK,      0x57000, BIT(22), 0x268c4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP0_S_AHB_CLK,   0x57000, BIT(13), 0x26008),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x57000, BIT(26), 0x27020),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_CORE_CLK,    0x57000, BIT(25), 0x2700c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_M_AHB_CLK,   0x57000, BIT(23), 0x27004),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S0_CLK,      0x57000, BIT(27), 0x2715c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S1_CLK,      0x57000, BIT(28), 0x27298),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S2_CLK,      0x57000, BIT(29), 0x273d4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S3_CLK,      0x57000, BIT(30), 0x27510),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S4_CLK,      0x57000, BIT(31), 0x2764c),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S5_CLK,      0x57008, BIT(0),  0x27788),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S6_CLK,      0x57008, BIT(1),  0x278c4),
+	GATE_CLK_POLLED(SE_GCC_QUPV3_WRAP1_S_AHB_CLK,   0x57000, BIT(24), 0x27008),
+
+	GATE_CLK(SE_GCC_EEE_EMAC0_CLK,               0x240b4, BIT(0)),
+	GATE_CLK(SE_GCC_EEE_EMAC1_CLK,               0x250b4, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_CC_SGMIIPHY_RX_CLK,    0x24064, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_CC_SGMIIPHY_TX_CLK,    0x2405c, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_PHY_AUX_CLK,           0x2402c, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_PTP_CLK,               0x24048, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_RGMII_CLK,             0x24058, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_RPCS_RX_CLK,           0x240a8, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_RPCS_TX_CLK,           0x240a4, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_XGXS_RX_CLK,           0x240b0, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC0_XGXS_TX_CLK,           0x240ac, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_CC_SGMIIPHY_RX_CLK,    0x25064, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_CC_SGMIIPHY_TX_CLK,    0x2505c, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_PHY_AUX_CLK,           0x2502c, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_PTP_CLK,               0x25048, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_RGMII_CLK,             0x25058, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_RPCS_RX_CLK,           0x250a8, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_RPCS_TX_CLK,           0x250a4, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_XGXS_RX_CLK,           0x250b0, BIT(0)),
+	GATE_CLK(SE_GCC_EMAC1_XGXS_TX_CLK,           0x250ac, BIT(0)),
+	GATE_CLK(SE_GCC_FRQ_MEASURE_REF_CLK,         0x18008, BIT(0)),
+	GATE_CLK(SE_GCC_GP1_CLK,                     0x19000, BIT(0)),
+	GATE_CLK(SE_GCC_GP2_CLK,                     0x1a000, BIT(0)),
+};
+
+static int nord_segcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static const struct qcom_reset_map nord_segcc_resets[] = {
+	[SE_GCC_EMAC0_BCR] = { 0x24000 },
+	[SE_GCC_EMAC1_BCR] = { 0x25000 },
+	[SE_GCC_QUPV3_WRAPPER_0_BCR] = { 0x26000 },
+	[SE_GCC_QUPV3_WRAPPER_1_BCR] = { 0x27000 },
+};
+
+static const struct qcom_power_map nord_segcc_gdscs[] = {
+	[SE_GCC_EMAC0_GDSC] = { 0x24004 },
+	[SE_GCC_EMAC1_GDSC] = { 0x25004 },
+};
+
+static struct msm_clk_data nord_segcc_data = {
+	.resets = nord_segcc_resets,
+	.num_resets = ARRAY_SIZE(nord_segcc_resets),
+	.clks = nord_segcc_clks,
+	.num_clks = ARRAY_SIZE(nord_segcc_clks),
+
+	.power_domains = nord_segcc_gdscs,
+	.num_power_domains = ARRAY_SIZE(nord_segcc_gdscs),
+
+	.enable = nord_segcc_enable,
+	.set_rate = nord_segcc_set_rate,
+};
+
+static const struct udevice_id gcc_nord_segcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-segcc",
+		.data = (ulong)&nord_segcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_segcc) = {
+	.name		= "gcc_nord_segcc",
+	.id		= UCLASS_NOP,
+	.of_match	= gcc_nord_segcc_of_match,
+	.bind		= qcom_cc_bind,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

