Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84749606EE88
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=usDEGhTU;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=puKAe4Li;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MKtXBL3d
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 616FA4072B;
	Wed,  4 Nov 2026 16:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tQYW8QGexPQ2; Wed,  4 Nov 2026 16:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 88814407E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793810244;
	b=sVlm12ErXQVv8QIe0eqB16Dy7pDMvvPe/Vk0jDOGZ0fjj2PaL6+byinkWONP+S2iIIFf
	 aBaq2m5Y7nkq3UeCg4DYes0grqHKUUrbX3UgSA+ZY4+Y+IUulGPw8Ewm8QQgcLhQwmsDG
	 cU64HSopgFayhqegxZfI5Yu0JY0G0EdcVEwNbvuNDVdLyEuzhdrRE7jTkDptyKYL4jayZ
	 bklmvIz7p4WORc7Zl76yMyrL9MufxG4LC9cJIAJXd8rLUrNvMzBHwrYw88bs4Klr0gmwf
	 3mc2vVtSltmuwDjw6MrR3K0/1VXVigJFwI4e7d88e2+nGJtD+1KZgtgp3cUlXbQzyCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810244;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=r3Zf8F7KsPSkAjJEuhZuvmTXVO9FMxafHrzgCbcv340=;
	b=UfCMZPgakmcASziVWM4vC1btmgCneWUde6230+C0GMnN3N7YfsYGYFJ9yVKSctdS4fXB
	 Upo/BJaDGuqGEizgj6MJ1BURePswa0sHuJvUci0x+EcPGsLeD7ywzR+Fhag4Z0khGMoMY
	 X2YoV3nKxV2qBSflyDgTshy4QFD/g04T5sUnAED/xAX3bRiAquUDBhxxsOrUWb1PZ5Bsq
	 HNEYX+eOMJyI1cyuiZhUJC09hySd9UbY3/S/jXYXI9Od61j6Z/wRQ7EVxa/ahXbFL8liD
	 YfR7XgkDQztbSy7KxyeDk8JgmoIW/iKnUAsoIR/x9fM8yElM+SEFFzjC3jexbbwFCMA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810244;
	bh=r3Zf8F7KsPSkAjJEuhZuvmTXVO9FMxafHrzgCbcv340=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=usDEGhTUyfx1MysfjPJlIxaDVzWH+GzBMqobyUHiyIjsp6pNbFpDMwJ6Xa/Eovuli
	 j0iL4JZzoNihXDI3B57Ck+7mcZZ5IjsZCPP9+gcS5O4NZkP9qEhtNkMZ2IsUe9oZb4
	 LCVEXgTC+wZrtr0a8wDgObum+MhOYmu3F1lGJs/iZonubnvRr1nv8Qt+lS9DQPFsl2
	 4nGdL72TxTEUsyaRrAozXvuYSOt6cXZPqPRo4lGVpJi5cVMhrEo5cCQN36h0JaSd+6
	 B0Xo0HbsJNMP4/ALg35Pkh5WrmVfpGKByr7N5HMBc3mgEa8GfrbfS1e36hqgf8dXuG
	 R5fmOientNP/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 88814407E8;
	Wed,  4 Nov 2026 16:37:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AA27932A
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B56C40068
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1kYO8CWwzEqb for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:04:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D037840062
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793808262;
 b=AZrEhUq0c5+30nfb3W6sDCLjrXEPHkqbCBLV2PEqE84hLiRZmgEwjAbrWBismPi9Somz
 6IBIErFSFZfVAeB3H7H+mZ7JwwNZjNlHZ6xcEuYmVdkw9U9G8J7DvxfQrm/O2Ki3l0042
 gmF0lZWxlkYJ7yZs7qAookz0iuRUKxm8QP+FrNEtmnK6F3WnDgYEV423j8qpnuZHICWPW
 qEQioXI5QU/GSGz/8wDK79GpndJsnKTTRDt/8SMZYbsRiSOZmOvuyIgIdkUQqdvh1WN5u
 I7DUo17zI2thwSuBkQUGo+5aZNsmEikkT061A9hojmG6cCmTLUvxCwgehAjt0Cka7qQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793808262;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=r3Zf8F7KsPSkAjJEuhZuvmTXVO9FMxafHrzgCbcv340=;
 b=LOfgF/R1nIdoEkmldSPwcLWVjezP0ototVv9I3uFoP98BetJ/EdnySvRq3ZckfxKNgCH
 Qk/iK6pdo0mV3V7zXT9PgkZnx4WVEBJKGNdEP9XEBTZ1mcuIKkrUPsCJNS/chNPvg6oia
 9nxMUfDGYFVvz/o4Ft9txEIO0hS/FAZyVTSNiORCHWplsyvSyr6osY8AuO+rHUg/ewMgn
 T5zlH5Q+9Hyd0gCHf42Mvrcou8f3PlbJcLlBMaR6ph9FFY7aqy5NLd/Icj96x3jsnJ7zM
 fa4Br0zJElPg9nJU5+OYowbrjI8EOtP6R5hC6liDowcoh5JLB5xoXqzXgOduu8kbmrA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=puKAe4Li; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MKtXBL3d; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=kr.sowmiya@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=puKAe4Li; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MKtXBL3d
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D037840062
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:04:20 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj6uY1149186
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r3Zf8F7KsPS
 kAjJEuhZuvmTXVO9FMxafHrzgCbcv340=; b=puKAe4LiMpFhUKu0Mp4fZ7orTFx
 dFpJq8rIrNUiIMd3ACriPjL6OKFQNtrElzVB786KYxgvWODiBYgtCZLNT6Ms2gUr
 uiklURP4qcRm2j7GkEu5vuEhOM+FjhtcNaU7jgadWs/o8xzE2DuWX85aohncKMWe
 X+f75f5OrJ7gAqwQCT8klmv0YEstN7ATpFTKe0iHf7Bp1Yh0jWRCb853Jse4QFse
 YyZVlsN0zYQDqvNFjZgQb71nzvojiT8wLt4DlL967ZrcMbl5cJ4JNgu3rtSz4PQ8
 ZJeKbpyU7jBKHjiofxG7ppuJN8X254WRpf6HMgFxurQB/2lYEPdYQKY3poA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr3r8147j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:04:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3425098ae4bso2824808eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793808258; x=1794413058;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r3Zf8F7KsPSkAjJEuhZuvmTXVO9FMxafHrzgCbcv340=;
 b=MKtXBL3dTVxdSRG9x5I9mmoTECsm9Fd5wvV5+3ZeaJRzbjuLKC1u3gpD9tLA1NMWvt
 n78UkIOwf8p90gTDTcA6abz3zURhy8J2NE+yDgdaAECpQzRs2jDBycF0TZcSEmHEcz3L
 1gocvoNfbnLLR2HLG2Y1oQaZ/WpOJQWLC+RwaA6QHZLXYDGiS72ru2Rl8riqaqQwMjJt
 zfmbnuKL8K5VTYNnoLqEgFU/luIMgCgXrM9LQm86amhQ/KDTFDpgY5pVtlk1tkak/sYI
 simTTD9STfjVav5RdOEN5d/s6GmxXZrrG2yeuVJVfH5cfEs1EaW77P0QSs+NS1AIUhJW
 PbsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793808258; x=1794413058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=r3Zf8F7KsPSkAjJEuhZuvmTXVO9FMxafHrzgCbcv340=;
 b=jTW3BWewfXPWHfW3fHRqTcpIzeLRSFSwHyBk0x2mdTYiDCuROp7oPy5sM24mXJlqV8
 tA8GiOuWuZsaitLApNMNGfK9cb30REiGrM9plkPMJcHYFL8/RK1jsfcutk5ERDEefha7
 kbjPuObN4hXSFVRUW8BefgOPI9voQYkFC2dYAfoSBFo1PWQIQgT1JwrFLq0KbIPmhd1B
 4hHc7lcfZCLW4EBaBZYK73rh68P6PPI470iZ+JgQ53mahjwaCh5lsiH1qEuhGzcKH/tj
 sT88Ow+rBEDg5KyaF1G17cyb8nP56zJ1hQEqmNuW9h2hQMjJd2M+WnDI2tvn3IhgChRo
 xfTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVrqTLhL3ohfwmJeEwnBesU+Z/ZHUu6EB0A/0INIykq0T5GN8VpmcQM5naSiWZ7HdFAbaxBrE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8gXfHup1MHXiDNC+/vIgyc81UWYT1NYwzxx8VRt7yx2ICe8gF8
 EjB2vuCiVQkaMF8BaFDpv2+Atzzjrkwa/ILgZjTXzRVWjG4pfR3FkmGaBUSat9NXZMTkxBCJhXC
 xFZ1nlVQ+T9hSNK8IoI5BNn/m0G9WctYuok11Q0La1KET6GUuH0TDctRBAJQ/KjvoOkI85EY=
X-Gm-Gg: AYBFou0KafkQSdEEyhd4YGXA7cAxAo+oGXbFFUCMfODxZ3euEb/hKsTFICelfRgGOzF
 /NH3mt5xMmUQoYBPWkK2muiKptxoutKbzci6nGIoUPAqt4UE8Ur+ZxvZB651F7KJpZSg0+KSzMB
 Lz9b5XB2+FFNZAuHUblOmSHDzZQSzlkoqVUU5UmtPl6VvZV6izSGqTk033nDaHkRFqbZAOWzvrx
 ecFHPRbcfUwaX0xfwVL26cuemA3B+v/ud7UvHQVeJRVGuxy8WUfZxWuW4nRfN7LWS4OEzhbcZEQ
 f+j3WZzqq2sojk5ow1a6lX122dOuWwleDkvrnIwi3FnP9KtmR6vBd5FzHQaiepPFjaEkeILI8WL
 mHB/AGzsyRuw7Q4GfIZ0m4erP5AvGGCFrdUn5Wv4jJjlJKIru65AsvAfyZAcc899LJgAdnxMLMC
 j4W7I4syzkxhVZVatl6xY7wRvNxQ4+ZxE=
X-Received: by 2002:a05:7022:f105:b0:14b:1ef8:698d with SMTP id
 a92af1059eb24-1ac5b3fcbe0mr19592342c88.15.1793808257410; 
 Wed, 04 Nov 2026 08:04:17 -0800 (PST)
X-Received: by 2002:a05:7022:f105:b0:14b:1ef8:698d with SMTP id
 a92af1059eb24-1ac5b3fcbe0mr19592313c88.15.1793808256741; 
 Wed, 04 Nov 2026 08:04:16 -0800 (PST)
Received: from hu-ksowmiya-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm10882667c88.15.2026.11.04.08.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:04:16 -0800 (PST)
From: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 msp@baylibre.com, kr.sowmiya@oss.qualcomm.com,
 abhilash.v@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 vincent.stehle@arm.com, daniel@makrotopia.org, francesco@valla.it,
 anton@binarly.io, aristo.chen@canonical.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 1/6] pinctrl: qcom: add Nord SPL pinctrl option
Date: Wed,  4 Nov 2026 21:33:53 +0530
Message-ID: <20261104160358.1131694-2-kr.sowmiya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
References: <20261104160358.1131694-1-kr.sowmiya@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ss14VBWHHGupZxymK34_gOAgtto9f_RK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfX0Tiel4RN265q
 0WLuqcSOAC8OiCMCY2LHI93qi2T1TJXRqVnb0WkpFzglqp8Oc3Ghb0e7x619ONm3dmUrXVCgcOZ
 7QeoUvIPqxs6WHXspfdiwTMAEapAIqWkuTJh318osorNmWpscj9aW9m8oV5tQuQ9r3qXSg4hFMp
 7DDGXXMzt90ZJwpGTOubLyl/Co4rCL+xQZdPtLpGHwu9/j804fqASIN0CEiW935mgPNWfCwUsfx
 8k0ryEWQ9QmHWi5zPAlrdq83LcdcWHWIZUWnq3ronkNymzcboqptCTPTvjjT70YJhdL6cRhh6Co
 AOeLKOS1RVMzIkym2RPXYQZvJTptPdfgBAdgzdLWyvUFfRZIzBqPP74pQKU73M4jVRDOFdI7UxX
 fOvkjlkGWPIXBaOd8ja1eUrMAUQakrnhdLoD9s4uAvQ6n83E84tXBHLsdxisl14gUJ+y8F1sD4p
 BnaN8LYqpVmfKMl0tnQ==
X-Proofpoint-GUID: Ss14VBWHHGupZxymK34_gOAgtto9f_RK
X-Authority-Analysis: v=2.4 cv=UuP2pOwB c=1 sm=1 tr=0 ts=6aeb5782 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=EodarjjIn6b3IftXuCYA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfX1e8umbgabL06
 EFs7lHFR2nj3YfK8vz9kd80U9UJxjkMCd558IxcfSR7Vs2PUVkIirJbAAx/X6yvb3T7hITD9UkR
 bYERXLLE6SJ+2aJwpsus9rpHx5joYeg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040063
X-Mailman-Approved-At: Wed, 04 Nov 2026 16:37:17 +0000
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

Expose SPL_PINCTRL_QCOM_NORD so the Nord pinctrl and GPIO
driver can be used during SPL boot.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: KR Sowmiya <kr.sowmiya@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 24e97f9c076..735ed4d810e 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -78,6 +78,14 @@ config PINCTRL_QCOM_NORD
 	  Say Y here to enable support for pinctrl on the Snapdragon Nord SoC,
 	  as well as the associated GPIO driver.
 
+config SPL_PINCTRL_QCOM_NORD
+	bool "Qualcomm Nord Pinctrl in SPL"
+	depends on SPL_PINCTRL_GENERIC
+	select SPL_PINCTRL_QCOM
+	help
+	  SPL variant of PINCTRL_QCOM_NORD.
+	  See the help of PINCTRL_QCOM_NORD for details.
+
 config PINCTRL_QCOM_QCM2290
 	bool "Qualcomm QCM2290 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
-- 
2.43.0

