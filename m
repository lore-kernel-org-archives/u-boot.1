Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EBC606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ql5qLkHO;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=c39SbVj1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PHY6B2mf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9016B60870;
	Tue,  3 Nov 2026 15:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pO6_s1zZgJT9; Tue,  3 Nov 2026 15:40:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8D49360822
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793720414;
	b=YHxb6ieZb6zgJ++A9RcV4B12bExhl7Z/3vKrIpdFyVlLmuhtdYnEDTdI7C2Bqc31+KSr
	 96xBVgqYK7viaUMqwaKpC6TDE7OTrCXVTSwAT+4lS6/QVJlK+BZC2FraLfueqaWW33W2I
	 WVQvspEWfNbcdovgf5O5xt063GCqA68ZHVb3dOOkMOEohwccApqeFFX3uT6HdLBbUkGF6
	 TSSR4RCt/7m6wmB4eWDB96+XtRTsxFa9BpCFTECdr8kOM2BzyMDVW1TQmJ+0lY3GNNCMv
	 ZHjZrj9XNOYfEV+iVsnQlq4DaO8JaRXTPwm3zEn90hQBZHfZWDNGqePSGAavaERszKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793720414;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zLPt1UNpOTVu6thDBqq8CllggLwoTquUjrbJz11pjDw=;
	b=dMfJT/ch32mBok9asvrVWmvfKkr46MZdmy41J8e582mDAGeNQBzi9D3bhE0GQEXoFalJ
	 4pM7LSSkXbgTIYtApCEb+OsoSuKTbyTXKiDBYVj/Z8RClwiL8+vcNPLqBcpn9E73mUXpk
	 pU0IMsSrKT348/sJWBQEn9x9okWTf+p+XgEtHLLGbWUeTelfm6/OnRdIiINFC3ksbVKOd
	 sbX4BOQe2C9ypqSiqm0ZDZ9u9b579h/HV6OkmM88b+ahfu2GuUFX1FN1/ijJ3sL1rueuz
	 ARl41VrgAE4r70OEelx5VyQKHTurYkc0cZDUBccY0kwby2RKjBhx4WAiRZWIgmUI9+g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793720414;
	bh=zLPt1UNpOTVu6thDBqq8CllggLwoTquUjrbJz11pjDw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ql5qLkHOlN9/8v5gNNQHg7qqi+2ajYJyV67zu17IKW9oKgHc+2i7rZZwaKOS8XcaG
	 gm94RWdj9Qlq5MTO5OdbfoPZ8wRAOg2Kt3I1MhIigY9MlZNbYh/Op9IcVUytAyYl0h
	 pMNVUca3oGKnUcL6TivaqWkQvIsZb7xxpaCWb6XV8zbv/e01Tb48RMjSVZTwHKm58R
	 7lu+qSI92Klph9CkPfAblEUc9l9UxVEokBNfDxVkhKrqGt7Iu0CZD+NhzrWQWuhof0
	 0kDEW+PxCNILmQtXp8GYTsv35/ztlLNpNFEw9rnNZnk4uWoLZBqi4YXsWegHcnZTaY
	 kvgua/UokL0ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D49360822;
	Tue,  3 Nov 2026 15:40:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E01DFA15
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D1668400BE
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:40:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9DW3szlnxdEh for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 15:40:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5224240068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793720413;
 b=lDqI4lPT31nGpdvnKVs5QPZrRP3E6HE1PPZZ5f0hzJwhz1PDWecZkhieHZoenEQHF+g+
 EVHEjOxtwMyaOJjgjRusEFrNaYKGeobX6wsrO2XqYLpain3JMjKRdY+lToO1SQbOAy0Cu
 cJDeNHt0MsJeKvcn/1cxwL5OKwV9MsbtyV/ry/ipG9W8qyQZ/e+TxKKKbEdv5pbtYYH6b
 eQOtPqzETK11ndITj50AYHwsZb7THmcfGXMHS5MhilWk8MvJVFT6nvSG1B3xOilmtzmlY
 ipYMz0gD7+n7HnKpl0p66UCk4TOlhZlzuWiFDBGFkl1RbD6lQ2xG5gK9F7mGU7ISTaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793720413;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=zLPt1UNpOTVu6thDBqq8CllggLwoTquUjrbJz11pjDw=;
 b=ExwxUS0cGP6kTBd4kNsg2rWkdLjo9mAJqneDBE5ZTO+GPPmosYxp9QEFBU7A9wbQ0FGU
 0j9f+qgSo6A+zOSkrq7/l1tFZ1g3RpeRpCEjD8W6RYW3GV2ezu5T0Zp4v7EuQDajctEuM
 g5MJiVSpbz/w3IUBF/JoTfCwPnkqM+0PsIi1eJzFi4Qxf5yQvGcVrwjsNx9GjfimNpe1p
 XSe3utsr9OaG2oTdnEP034OzAFGOWj1vIqjG2eSaJeqjKacPbIvu9RnhfPXcD12kjpUzd
 FOQCKFqk47mrD7WYLKcgzN1d6uCZ191uBzeP3BOgKhCmhpeNIRcdkmYiCotxDxjArrQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=c39SbVj1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PHY6B2mf; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=c39SbVj1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=PHY6B2mf
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5224240068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 15:40:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3EAEvx3689956
 for <u-boot@lists.u-boot-project.org>; Tue, 3 Nov 2026 15:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zLPt1UNpOTVu6thDBqq8CllggLwoTquUjrbJz11pjDw=; b=c39SbVj1DCnYGzox
 8oukyHV2D1pGctk/ikA7eUSIqI57b+m7q4I24tuXbs9KejcHsE+Uh//wzTHom8H6
 yo20XUsOqOBTlskLnsmzCie8liP7kmnDIxWHf0gxauogun9PivswWFdLTQgiszpa
 1jR1jt071D1mgptAwJdlzT+BBC0onqOUHsVqE/mP0svi7nGDBO2hCMpPJbVDJxD5
 73x9JYOcMVuPgYLom8WBu/XG5ZBcXv5JA7W555BDF237ttOl+1gIF1t9lBEOrmWj
 XCGOKFdjwceolPCfneFPCTjyFBWZo3JfSpQ5HDASNDBfvz54kjWcH6a/R7pwtvJL
 Gz890Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq6m9b0j7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 15:40:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so8320251eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 07:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793720409; x=1794325209;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zLPt1UNpOTVu6thDBqq8CllggLwoTquUjrbJz11pjDw=;
 b=PHY6B2mfsfq2Vo5jJ42o/nBNsaveAtEOGpeqxWLtvT+jTPir42MWDbropZa50jEDmr
 +zE/larvBZrxHgyK3JVclNRWiUTbzwzA8WRpxY4llneyqgJ1XDd3wVt8S9+iAf4fQTDF
 +r/Hnlo9jbJtdXheGsbK0Mw8zJXdGZlVNdt/7PqNilAfkediB5Ee4zj+LDd+c8Skr+xv
 sXwnPPdtVx87HpmcUQD+wbXgWg/PgdWi6AiuufDyfN4Xg42VpM4ot7cL6Kem0c7LEWm1
 djI9FbACYttTX/ktIGK5PNJ1OxHksRi4NWyMJezsKpYP3ZoV1uIUxl3lnhsm2f8VlwPY
 F/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793720409; x=1794325209;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zLPt1UNpOTVu6thDBqq8CllggLwoTquUjrbJz11pjDw=;
 b=AO5hwo6DspaZQPqFuvSZC82PAlhHbR28W97T4HlHyUOGy4BtqvjYUk3erH2UG7zIGg
 8pWVdnVwJxZtucLv1hKeSM7waguAzMRzTmH246kgiQYQCGMJXUD4xkSai0yLn0J46UJD
 bLPajoLNK8g8hDBsGm79LisaSjCjgWRj4lwsKuUHm8MQtB2rr4V1pD1uxpFo9D9mdFw6
 GRfoAP7j4Fe9R9FSQpR/suryJlWU8eoAR/tXbqsJT5UCiEbxEQVCSOEyQYQlXD9UwSMO
 14Dd4/rOgxYfWjCBUoQq3dDkw4ForFCwQzhSymsIBNxpADpwHBJO5zEkUcxML19ZDtmA
 FXoA==
X-Gm-Message-State: APuU4Z/NgHoedd8lONrU/4fLhz6IuwZ6LrEoTm6EmFX3ebjuNWK34pbn
 ibpCKrf95xUI8DNGRTtsoRnoV2xru0eNGGvQVGcJ9r8tvV+7re+4TowUMADoI2CkAXK8EVHMjas
 6bXgoxKmk22NdQUqCv8KaAAcwdmxBo8P3FXryxzOfxhMkq0EfAR9FSUKuCXDo+iY+Ed/LIjs=
X-Gm-Gg: AYBFou08i4nPFHcPefd5FoY+zWgzaPbxVJ5em6WF5vTQd62c68nqMYhJkV/VULfCS/a
 6JZchHy4IjbLeBC5UzhFmA9PP+vS/zpB0AwNaCop1v18OeGMMkJF1Pl73yOL4757zPQQZBZkPP8
 dp8j4HpBSkAlOhzr2ocnCzAw8nVt1eo1CwjL6tF4THg2xwzHYzp5X0abFd83H28xYVfbkV/Uy9/
 gJrIZixnUvOwvxYyz5PduTIZivslwOIZ4FJEZVBpOeBRzUufZcuC3GCwgFvKAK9hiM832+cpb9K
 hD+2AkgHEtZ12Q2w0SXwFa3S6xSRJMgeQRCyq/sKAaa7N7EGS4fTQ5YiDT1MOAfEzjbO7kjmYXu
 w/L3VZf71O1V8nsO30LOKBJlXneTHkpz5yZwmcc/511jgvTqw/gNT4kMp8PhY+ub+rX5nBLydep
 j1p7CjFoU=
X-Received: by 2002:a05:693c:88c8:10b0:36a:1f:9b74 with SMTP id
 5a478bee46e88-36a423bf83emr20268591eec.27.1793720409179; 
 Tue, 03 Nov 2026 07:40:09 -0800 (PST)
X-Received: by 2002:a05:693c:88c8:10b0:36a:1f:9b74 with SMTP id
 5a478bee46e88-36a423bf83emr20268549eec.27.1793720408565; 
 Tue, 03 Nov 2026 07:40:08 -0800 (PST)
Received: from [192.168.0.5] ([49.206.97.141])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm51037724eec.7.2026.11.03.07.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:40:08 -0800 (PST)
Message-ID: <8ca18c8a-7446-4666-b8bd-e5ddfc3b490b@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 21:10:01 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 8/8] doc: qualcomm: Add snagboot mode documentation
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
 <20261021-snagboot-v9-8-18ce3e431320@oss.qualcomm.com>
 <20261021175256.GF3275858@bill-the-cat>
 <df45aef5-5172-4d85-82e6-331b5594eb5a@oss.qualcomm.com>
 <20261102164156.GX3309461@bill-the-cat>
Content-Language: en-US
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
In-Reply-To: <20261102164156.GX3309461@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LdzDMUChOajlFeORHMz74_drY3e4_Vr_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfX3NXrU7or/hfj
 /X/4LkTFVpFFhaiiTs8Bi2KMcXUgOEL6ZaMbqPkDWmwD1XHJXOy9WXLGgCr2e4zPSdlA9EkEHtd
 NvGglH/1eFoNhmZdQLqw3HN9gAn/Wek=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA2MiBTYWx0ZWRfX46uJLya6pVcH
 CxO36np0Fdx72Tl1mblj+/v2AOvv2EEObUqOaTMKrZqglYc3QlBG+Z32Oxv2o+5BATRk3glhTme
 blpu+eVTXrhWvIILON3NcWaX0MkimakEbLRuT2ewqKcQbKNhsGatjvX9FW+p7OBEjqAOAOaJHY7
 FYqLMOjHBfxSigZY425kk64YuI+GHCkyOoy3TRKy6Yw++onbf8z578+kEj7pLQpvxaiyxb0Teoa
 bSAuOp94l8tKFmQ8o7Vq00jxelI+9LFyk5jperHwe1e11BUsXTIrpfrfAEk8FRlMi6yn78KWMoA
 Jk6uii86yCoPIG+WdXhk6wamCr7v5p8zbqC8kGNqv0vFjfqznSnHjDGdK3l8i9NpsJk4Chjo7ea
 0ZkewHfdKszaQjWFRdTWmkaico6NByOidZFiu3dPoBU/4JDgR9QZgxOXhopC2cKA+7ufibaiVFH
 Z81+kOqtb1Oz/7A/E5w==
X-Authority-Analysis: v=2.4 cv=C7B8WgP+ c=1 sm=1 tr=0 ts=6aea005a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=nNSuycJrq3YNisLFxgOcLg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=zS7tBg8FYKWP3aj2WiIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: LdzDMUChOajlFeORHMz74_drY3e4_Vr_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_03,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030062
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On 11/2/2026 10:11 PM, Tom Rini wrote:
> On Sun, Nov 01, 2026 at 04:10:44PM +0530, Balaji Selvanathan wrote:
>> Hi Tom,
>>
>> On 10/21/2026 11:22 PM, Tom Rini wrote:
>>> On Wed, Oct 21, 2026 at 09:48:27PM +0530, Balaji Selvanathan wrote:
>>>
>>>> Document how to build and sign U-Boot for snagboot mode on Qualcomm
>>>> platforms, using Lemans-EVK as the example, and how to add a snagboot
>>>> defconfig for another board using the qcom-snagboot.config fragment.
>>>>
>>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> [snip]
>>>> diff --git a/doc/board/qualcomm/snagboot.rst b/doc/board/qualcomm/snagboot.rst
>>>> new file mode 100644
>>>> index 00000000000..716d88b2ba2
>>>> --- /dev/null
>>>> +++ b/doc/board/qualcomm/snagboot.rst
>>>> @@ -0,0 +1,80 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0+
>>>> +
>>>> +Snagboot Mode for Qualcomm Platforms
>>>> +=====================================
>>> The second line is too long, which means you didn't run this through CI
>>> or build docs with warnings-as-errors, as CI does.
>> Corrected this.
> I hope this means you put the whole tree through CI.

Yes, This is the CI link: https://github.com/u-boot/u-boot/pull/1069/checks

Regards,

Balaji

>
