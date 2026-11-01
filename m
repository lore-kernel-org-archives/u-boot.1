Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE344606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v3EOy9L7;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LFchJ1Eo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JSNpa2M3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C21DB80F92;
	Sun,  1 Nov 2026 10:27:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GqM2OPAGP1zK; Sun,  1 Nov 2026 10:27:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E3AA080FA0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793528852;
	b=HdiTdoXzuWR7OYW/uypQQkDuyfuR55zbNwafTQvPIAjGuOK4VpTWibFaykb1O8Am3im1
	 6wQ9Bjlh9tVZ2nBNVkQdk8kT4Mci1a9M70MipZr9cv1X1V9Kcl3/anDGsNlzs/vzk40Xb
	 rx+3rug7wvjEw+I/iGfTcJnFyXxonbMLI5kZtcoOYDBDJHfpki7f2ZAsI7pxk/KgHI91W
	 UCcr4MMmSVZckXGTsanpeLsPeKqs/mP41OwJ7BYK+Iq42J6yp2OTG5895sJfbHbwMa1AB
	 fQW+i8nT1MGprBhgFFmOXneAfSwA2LUAMpqZG5w+ftBkz6xDPWmVABTDHoVlGwnhcsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793528852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8LVEJ554/uxo6zK52GwraUlONvgHAforb2yeF/FtZR8=;
	b=EUBVYiQgqIOdx0nPVYtT1F1pGgrKaVH6Eq0MHf0EBNoHtsaN+KrFn4R1+1dv6WiwFTEX
	 fz5phDanc5kILw2c7Im05/k93rEAyCrj03wCRwV75DkL04WjoaQuScsJ6XimRlg+yUe9t
	 XE+MFCf53kjbRFcRcdGTgyDUQ1ai4xssQBebjuDzlOriIiRQykLmXbV3ZZcwGqfr40BjX
	 ooMJOJrw2y27VE8hz5HrC20oBU/6y6aOxHXg8AR8oireTCX+Pc3yD4Pe2TLrA6NeQvxNJ
	 gMCuyxHBvqkad+dIu5xY/tl3lOf9nLzt0cdruoeGiTtCNNGgESkchxFK5Z80SeMV5NA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LFchJ1Eo;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JSNpa2M3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793528852;
	bh=8LVEJ554/uxo6zK52GwraUlONvgHAforb2yeF/FtZR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v3EOy9L7EFiCWu4dRenTbQan0Bbam3UUe6aQTxnlAP3qhvwp8r8Bixj++mWn8oeT5
	 I8oozj6so4Cuy3Ota0Rz6qnf2YP9869q/3CNaX/vMqmZlM6bkRUvN7HbqUVu1dAs2K
	 esT+D31XTuchwOF+YSQPRHcUJk/0Z7fOvxEEgkSo/rI74g/EzlwmyRvE+Xj3NcnfhT
	 ogX1o8QWKQUCdL7XHLrhvQHCRSJ0BBYCEMWcFkJAsF9m1i5jyAHFvg+oEbIcrm5Omk
	 LAqMKL6YRFj1qoW7TDzYFBIP/BHgBjHV4QFwEuaBtBe6V8DmuxLfuBwj3J7FkK6oIi
	 AwQ/T2HJ/vVtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3AA080FA0;
	Sun,  1 Nov 2026 10:27:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF8612AC
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:27:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C108180FA0
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:27:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bEUFVPujm0QL for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:27:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DADEF80F92
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793528850;
 b=BTNAXX6oPgKAaM/KHHHibDNwSLqL5441l7+ccZMEHojwOlkc1AWZXUsMHka8AMrsJEW6
 a+uKH9ZiMI2cYbp6a4peLe96YBS19J9j56RQUAzff8/GDOYcQkpXQXGTpStL5Xj54UIDF
 3/g5yNZbzpopldotv8HCkjLAX8Gnnv/03cB7hNRot7crlC7EidBKspNEwyfB+Q8vdXSUj
 JpapYEwFyo4Rn2Ps4r+90eyUfIjRKvB49uupyi9Eq+NM68sjAFARFiRpbNcu+G5bE6kVh
 951Mjh1uARHiIV18lsmCdsHQpyPTbsr41zV2UNuoQY8A/AAqfLEuwaDb9KMeIRx+/5g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793528850;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=8LVEJ554/uxo6zK52GwraUlONvgHAforb2yeF/FtZR8=;
 b=ivWtYg5sFTyioj4RXdju0QAzZTsMeP10N+Ixt1tTpHtPKZWgFpX9QZWUDflRoNnojs2T
 uP3XoC0NUQbjDC8w15spX6QsiD731goJiwpvRBpoOrOV+qAUviab01E1d9VUCuzzSRXBy
 0znGj8iR8YqdTjrNHZlcLW2vt+02nW7e+Pg5BsYB/GREtBXQiczJbX1hCrQTnSo6oJL9D
 ssKAVBsKUX1yBoQ+Cd8oEpC/NJTiWJNxk9yUcDFPx6A4DXLOF1JOqAJYwVgXqL+DHnn5y
 SCAflaJPVcU68Vstm/UN8d6ofUfEI48OoBo2jkHTChWPdUDw8aFYHrCmobLGW4nJpEw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=LFchJ1Eo; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JSNpa2M3; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=LFchJ1Eo; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JSNpa2M3
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DADEF80F92
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:27:29 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18KSMS1321212
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:27:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8LVEJ554/uxo6zK52GwraUlONvgHAforb2yeF/FtZR8=; b=LFchJ1EoI5LjcKqe
 P0OwZ5GrAsHmVI3cvwXxsrEKpT1NhSzmXQiCq/WES+HEsiHgTkBHn5+q39t3rsrB
 zfMpIMSMi7BKC9N7teeT0jq7qQy6oJ01CMrwIsxW4IhUjL768tjtpsOE/C7QojFJ
 UCPjZzTWFEPGrIuubdE3U9lIqKeZPkBnfrKbl+QdDKbBzetAq6Fo7+ZCPHUZsnJN
 Je5vKtQKiYgbcPqoIdMa/v7p2B8fe43+eTzrUXL+pP+ZEE/ulmBpZ6g+WGpdsnfL
 UQ+SO3US+fpirPZPX7orTaoPNLbl+Y1MZeEeUtfE1FqnoB3Txx5mRb70zn4A0KJC
 aBpRbg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn61fuexs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:27:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36637676140so3027835eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793528848; x=1794133648;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8LVEJ554/uxo6zK52GwraUlONvgHAforb2yeF/FtZR8=;
 b=JSNpa2M3VC9WaDOs3RftIJ7OoKzIoZArI07vbjdEDNSKVmCuCas2K3uQave8S7ZfXX
 4xvzEuSmELpFk7BQOSsUFZAkj/pVAWnKMxoL1ZlEv0CoQHM1YDhaiNGD0iNw/eO9sc3E
 OIdpFPBzKiqJcV0zKUOzYrBh5mON8OVGYj0JxJJCsizjiBt2G8DDBhfQfQJvssebWpmS
 U5IVJgvWSVMAzXykwseV1aeq47uLTx932sj6jmV4QEzYcaqnN9ExzHFriBtkFsRA7dul
 3ZoJJrUBgWa0BZTHZWOSTi4Z0NRmoxDxKEgzGFOcqKVgKjjVw7ly8dn/YkhbdqGZz+OU
 /xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793528848; x=1794133648;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8LVEJ554/uxo6zK52GwraUlONvgHAforb2yeF/FtZR8=;
 b=rezA0uqQbnEIEG3RbSuMxy2Lkc9+UgfHfLHZ/zrAXge/Huz1L103XLsR3yfC5MSAM9
 dYzylW9FD5ngyp+v90oS6EzK1FvLPFsSJGj94ch4CB2ZlvzPqpGDsT2GcZnbKLSG//Vq
 nlcMwJOhVrw0r7EpvUu5MNPln8KJ/V63lBWnA8IyB/89FB91L8M7P00/RmgcFkL87u3D
 if+kjDnv+tjI1MDR+9qxXDwO5tCMEt+sKEjyOPKU3T7yY/SAx6optwbhxUfXPQqxYjTY
 PsaeDh5CyNBFeLnOE7ogs6LO+g3gaDUezesrNslPLTCSIlVkoALjdamhV8RRWPxZPy1b
 UjjQ==
X-Gm-Message-State: APuU4Z9bLrtm5vkYXA6eSRrkuJK53ER7cgUQ9+P5e6wgPVH3c6VtHxBZ
 iFkoDj050ebl0KgrMWC08pc99NQicvHQginrJjLCwyI7bQi7CZt10+Gx6mE320vt6IbpwgToTQr
 QPGJGCHIhunPn2CQ3aH9CS9fRy1OsJXR0O4QjvY5z14JdmKf9M+cJ+271uRaMlQtmWRkiIlA=
X-Gm-Gg: AYBFou2CkM2ifpk6LnAMBIbetFVUMHgQePO90nO/1pyBG4aACCiFNrmXHoaWh5oKyGy
 WmiVGkXpLoPUapX1+yqh9/KkD7m00xGN3UHmGEWtT2rR+dz9z1OxbHgfo/zXyyIhnvQwZ3NNkFh
 pQms3jtbZBaWEIIgBq/kIBeHvwA9QOBH6cmc8rkluc/IAktaX+J3BdwVpeCvnRhV6qstNHeUB9z
 Fu2huUh4pUio+eHmMcv35TaHG5lgDfXxHVScWQ6NckTSBe89Ru/KmeW61VZLENyP1BDXN7WqXuO
 a0d2B+hsohmeVT0EtawmcZVARVgrJoM3ziUBJ9tertddHDk8vJS5/n1gU9qNespEllluZ4gAsmO
 NCk+XVPS0zr/Ue2AgcvB8xHDXNBR7dNGnEPDWgr7FbI1Op0pY4iX9ZZuOYI4F9kBM/VYGJTkLhv
 ZjnIRVXmcM
X-Received: by 2002:a05:7300:d082:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-36a423af91bmr10752521eec.16.1793528847768; 
 Sun, 01 Nov 2026 02:27:27 -0800 (PST)
X-Received: by 2002:a05:7300:d082:b0:351:31c7:ab1d with SMTP id
 5a478bee46e88-36a423af91bmr10752507eec.16.1793528847216; 
 Sun, 01 Nov 2026 02:27:27 -0800 (PST)
Received: from [192.168.0.6] ([183.82.206.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a6eabbsm26795274eec.24.2026.11.01.02.27.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Nov 2026 02:27:26 -0800 (PST)
Message-ID: <a50cf673-5596-4c05-b953-3e1d9dea75d8@oss.qualcomm.com>
Date: Sun, 1 Nov 2026 15:57:20 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/8] arm: snapdragon: Guard PSCI functions with
 CONFIG_ARM_SMCCC
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Johan Jonker
 <jbx6244@gmail.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>
References: <20261021-snagboot-v9-0-18ce3e431320@oss.qualcomm.com>
 <20261021-snagboot-v9-2-18ce3e431320@oss.qualcomm.com>
 <20261021173537.GA3275858@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261021173537.GA3275858@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX/k4NAfQx2osk
 RTF3PnjE/LLAEBKrZchsOVEgpIzzQRv5qQ6vcNRIzdQU/qUAIBxKyIR2zQ8JLy6elUENthqUwe+
 uMYI5EivuGxdwwBfd1iolMok5YfAChI=
X-Authority-Analysis: v=2.4 cv=V/LoQuni c=1 sm=1 tr=0 ts=6ae71410 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Tp4+1iC1jwEXx1kf+84ntw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Kx7HBPYDNlbrMfLUM_0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: dkN_QZZKwsz0_5giWBWu4q5p4cyct4ce
X-Proofpoint-ORIG-GUID: dkN_QZZKwsz0_5giWBWu4q5p4cyct4ce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MSBTYWx0ZWRfX6bbb3ae/EAN2
 E1RoiVLeBUEaL6XtXSZk+HSEgH+F426T7jd+p71pgUmGFORTsRH0rW2/YnqtW0rDELHMYtg3h0/
 P6rOtpC8IZC1eVI+VmlfGvBfmCrd72a6hsPWmwQyrg0zVEnchwyrc+m+nHhbdhx9NvqEq2d6Amz
 y47dRGIAZvD+ESeT3LOPYnwKjQPEgr8g7oxHpgTUEt2DszV4s9sxt3CT53LpblGwZyg0DkzJ7D5
 COgijRYd013Uj/Jjg8c7v3vpe9BrMB4ew3txDtlkW7k9bn5Gz1rMJOxZXrbRjFdYeihsEPXo9dc
 Qon8KfPSI+Tr1og+kDuF5irdzpD/o+WgZSDp/mrDGR5wGO7huY4iZgHufpwHi1bDug1SWxGKL+W
 z7dawHPxhVTM4xCuUHL6bAAUkBCDy/VTQJmm5fTfYpD3FP1ZdEGFLK348/b+yp+WGiZ+heZSZmF
 Hw63x23dNDXaD5ZNXQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010041
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 10/21/2026 11:05 PM, Tom Rini wrote:
> On Wed, Oct 21, 2026 at 09:48:21PM +0530, Balaji Selvanathan wrote:
>
>> In snagboot mode, U-Boot is loaded directly by XBL without PSCI
>> firmware support. The functions show_psci_version() and
>> qcom_psci_fixup() call arm_smccc_smc() which is unavailable when
>> CONFIG_ARM_SMCCC is disabled, causing build failures.
>>
>> Hence, added CONFIG_ARM_SMCCC guards to both functions.
>>
>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>> ---
>> Changes in v7:
>> - No changes
>>
>> Changes in v5:
>> - No changes
>>
>> Changes in v4:
>> - No changes
>>
>> Changes in v3:
>> - Added CONFIG_ARM_SMCCC guards
>>
>> Changes in v2:
>> - Newly introduced in v2
>> ---
>>   arch/arm/mach-snapdragon/board.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
>> index 87adb100edd..daee2ed4fa0 100644
>> --- a/arch/arm/mach-snapdragon/board.c
>> +++ b/arch/arm/mach-snapdragon/board.c
>> @@ -35,6 +35,9 @@ static void show_psci_version(void)
>>   {
>>   	struct arm_smccc_res res;
>>   
>> +	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
>> +		return;
>> +
>>   	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>>   
>>   	/* Some older SoCs like MSM8916 don't always support PSCI */
>> @@ -58,6 +61,9 @@ static void qcom_psci_fixup(void *fdt)
>>   	int offset, ret;
>>   	struct arm_smccc_res res;
>>   
>> +	if (!IS_ENABLED(CONFIG_ARM_SMCCC))
>> +		return;
>> +
>>   	arm_smccc_smc(ARM_PSCI_0_2_FN_PSCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
>>   
>>   	if ((int)res.a0 != PSCI_RET_NOT_SUPPORTED)
>>
> Do we even need this, patch 1 of the series disables SYSRESET_PSCI when
> you're doing this special snagboot mode so we shouldn't be calling
> show_psci_version at all.

Actually its not needed, so removed this patch in v10: 
https://lore.kernel.org/u-boot/20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com/

Regards,

Balaji

>
