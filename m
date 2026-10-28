Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B853606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ajfSznvM;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=okrm4wuu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F12AF81103;
	Wed, 28 Oct 2026 16:01:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CK36wUp8MPCa; Wed, 28 Oct 2026 16:01:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F8B681107
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793203301;
	b=FL5UJly9Jzj/p7cMpQQS3F0f2TParUnaWZo9xk+0Adhq2bSMcior3+poNc1JPEPD1eTl
	 0zOwZ2KvYk7rHrMoRy1z//63UaXRPr/l5RShuJPWXIRCkY1uspR36lNnCVAkV2/6+7mXx
	 18PAPJ0hpVJ/A3v1BMU/9dLDAeFtuOafmFOl/5qNfKNYZ9baFTM9BCQ1QCCL+eXPh7yTM
	 60uKJd+54bvdwVZKZ10p+Iqkmij0vC/7L9mCNoVXYDe5B/y1VYFmQk6S/w2e2rZG7ytps
	 +nDJyTU+5gdl/4vfW+2fcZHdCPiKDi4WfCV2vtSmiZtM2tsaQvf2wvw+ZafDt3mgHgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793203301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0pJSXUHmdsbK8ANsYhREeaTh0zkWdjCaet9LqIZyX6Y=;
	b=ovdgoLiFt2oKRwAloRSHzDfPkXikVjHl6oxgIG1pJ4s51TnEQ7gLOz9EL6guFqzzkkA+
	 DlUw2f9p/zZ8H7DQ9Hn/IMdiU8SVE1N/DF0Y1YOknMK9Qh93s1U6u199Rwt9nllcTFzde
	 Eyld8A4shL9NJO5BMLCp9Pu8/VjCSSNZK7s69Ix0l/h0VQlK0QApNG8eDvkbPUii14+B9
	 I8la12jc+yXSAkSs0mC2tzK6tSununqGpeM6R+ECqN0YpO0VwwvUHMe2C+W/KVBySAtO4
	 RWf/DdlLN2kSkMoPbKbxMdMWpCHvUEi4pata6GsjMsDW9XgiQcKibZTHb+w8zK/7gFw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793203301;
	bh=0pJSXUHmdsbK8ANsYhREeaTh0zkWdjCaet9LqIZyX6Y=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ajfSznvMcQM7K9esk7WkLRgnP+9IHFN17Bj7uzPBDi1cOdT/jbVVf87BMlDsUZ1iV
	 Cmql+/sdO7kVkKS6iDHHGfJX9Yg/LZ78jrL5quyrJO+DrYUh2MW+mDIXJuPG5kDNfH
	 X7dARhEPITld3ni3EDc87WXzvcdS+qivFQVAs5IKAIlMjyuZTeDsI5NQzI4jXcGmuj
	 LNKrvPi0jxkW9S69DtcNWiQ6h39+2yuLdJWeZoyW+v/VWAoDBx616siHCdIUVDCy3e
	 6a6VRjiHbgqPb5wudVprm6aR1twWCp9Z7o/hGu/uJzgTbsKobAy8O51bMLIIGz3Hzl
	 +iFM9UA+xdVlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F8B681107;
	Wed, 28 Oct 2026 16:01:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A5F214D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BE0040553
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v_JItcqeOJv5 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 16:01:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 62B4440533
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793203298;
 b=moUNuPczG5Br2vqRw8Wei1fg90S2sq+BWOKv9CwAKhNigcDbgu6NkfI4ZUQBhi8YqH/n
 nJUEzY9lPEVNJ94uCAAhsVwIEHH5Yvk/uBYD3ST+xuyf4yoS1afpRgZ63eYSVC0jW2hXh
 0HlaXn97NuY6VL7AUIiXCUpRPS0NeF40Y3plTbKNe9dM6SNyoxcKQcpiJ2bBRl6p0SinX
 vzglDiMX1dJze1JE59OVCneNKIU467BM5K7nK4RQ8YzGh98iIKnBxuw4E4OBj1c93RJ5I
 NlsCYw06aOV6ai8FQdbugpKjAdEjEuylzlKlXHWqRYgLQju7lRBynmKwXxAyDlkcu8w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793203298;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=0pJSXUHmdsbK8ANsYhREeaTh0zkWdjCaet9LqIZyX6Y=;
 b=CRv2fGqT7jA2dpt0QKO6NLeq7crWR5Kxlj2lyw1fwyvVv38DL75b8ihMonqP95LFAPbw
 9yY7lLkKiy5YHhfYbRX3O3mhoXLDXH0lep3WRBGRyfq8o1dWYrHzPq+TtbQK7dgrGpucT
 ffRNh1XMGHy4iVGUPpKsrH8EKeqOpPpqH3Xbamwzlfz8pvsXxUlIegGsSywzkWUfpbuvN
 qbXwNHW6HXWAzSabZABygGLmTWu7C23zgWkkPkotcFg9szaKnxTxGCAP72ZZ3TNUr7lBx
 S7oYyzfvrGJ3QrUAjJHRSIr5gIy7A+w9iu04LNBUDv5tql9kREtE80A1V+xaPFpaX9Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=okrm4wuu; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=okrm4wuu
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62B4440533
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 16:01:37 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so10345655e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203296; x=1793808096;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0pJSXUHmdsbK8ANsYhREeaTh0zkWdjCaet9LqIZyX6Y=;
 b=okrm4wuuep/rySt0+reAXswUA541dNN+5ilNqdumCBEBsNPE5TXrT9I7tQKbldmTw7
 jTObUHEprC/x7KimuvpmD+v8pQJN8Bh+1YqBR0Fmaagnr8Iq8aWN6bxk0PXE3/+t00Xc
 +IGEMYSeiKPODaOIZcxg9ndByPu0c+CcK8/mvCczVpg9kWWyIfnbM1ds5mCD9tpkB8mr
 ZXgvPP7KD8aauQC3DVvPwdBjmk9W5LqLVwWM+Z/oYNPBGvsqebsUREARpsQJjunfrkwt
 ioPrJC98Kmh4LMM+s+WCIzQ4I3ITSuBLD6pNWpNUcefcyrKYE2NkjE7Jl7fRGksUSU7u
 UdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203296; x=1793808096;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0pJSXUHmdsbK8ANsYhREeaTh0zkWdjCaet9LqIZyX6Y=;
 b=GC5KR0bmqnVI9CSl9SkbMG8/tcnSg+3l0su6tqqCJhDWzdK00BRZbz/oUgDfTRIpwr
 dF+mNJSdKY0VAynrR1XFDPMqHATUI5QPBWFhLoYwprWxdd+XUkwy7SYGGjlVEa3MUqob
 9HzelPCWw3h8c1SvOFYHI8qs8by6g7j9Nb8oDhP+1KcxiJTMD1RnN4xNPqY8soM5OXZP
 6AcP7eEA8jd5/JulWg1sDbGlSqxIJifSjdJRhJ5ZFEAPNvYwsf2uTS0A+RmVAiKjQH3I
 79rLGijgrylWnvOOvosM7GYrEY8Apq+6OodQp2Sz0176WRqEn56TgtzFYS6N2Ii6B5gF
 GIaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzEBQfLkBZWRm1nQq6yhuwiQL48yhwkBuWxCrEVSfqyjKJpJJ9kHohu6CTe6PywIFheiybjks8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYK6Os8c6B7g7oUPrSqk7sNxpCuH4E3Be8sCisgxH8sgL83WI06I
 Y4ld77hyewHmlSDAgba/hF6BEAGjISzZjqpiFy+tKFuGqpGBvDIcobDNu7dUU4yZvqM=
X-Gm-Gg: AYBFou1WCpmjQf+/lAGfRDmsuhgQvjGxRVdZxf4Cp69dr7rP5A2TchnOcN3wlRsgsc2
 9rFvaudk5SEw1U+UJZzDgZSQLtFZbm6a9BV3FYRBk8h6jm1E+Tft5b2yxKQgiImduHrby8XjxzD
 B/raWdlpurpJ/mQdpHTdbXWE/NbiZS+fZep3ybDUw6rJcuyVeHkkhj9QKIULFpukBVtyp+4L2VB
 kOoSw8E/NlxtFXgHOi8SBnjgUNId7rkduZRAfFBKpl8/MhQ6oVBu9yW/bx4mRkcxD+3aw3fzqb8
 FyJfYyWL+bCUH+kppOgbkjZqF2fLJyo3pQLv36px9OhaiB57BxshZXqJTh4IC/C8v3L0LwMEHH1
 KADpz2Ae3O3QIkKEGyAxC1EvyZkwRbYcodt5hireKkCsTW0nmP3a5WX5jcl9sZ2vsTaV9XmACBg
 sIuiKEGYG0sedo4KLADlI8YZ8NDvyW5Goy+LKW08rRqhlsAiIhldu+mZ/MJ0Ou4BrLjbi8eEA4x
 Omb3fU2Qa4TLckN8WfYUgsjNiuqQjII/7vT6bwRt8C6ZyAByWDSGRLeHpsyrMlN+KZiEU1cwmE1
 orjtQKTi4iGao2xAPjdSKNmMPQJfSoDoHcK8DTcRPxyFwcyonnGgAgookSFI4quxbJeis1M=
X-Received: by 2002:a05:600c:3115:b0:4a1:f7f4:7cf2 with SMTP id
 5b1f17b1804b1-4a966774db9mr61591635e9.17.1793203295680; 
 Wed, 28 Oct 2026 09:01:35 -0700 (PDT)
Received: from lion.localdomain (p5b29ef1e.dip0.t-ipconnect.de. [91.41.239.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80286fc6sm1686155e9.15.2026.10.28.09.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:01:35 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org, quic_varada@quicinc.com, 
 Michael.Srba@seznam.cz, balaji.selvanathan@oss.qualcomm.com, 
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
References: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH v5 0/3] mach-snapdragon: Add early EL2 hypervisor
 switch support
Message-Id: <179320329382.1454330.390227726946440059.b4-ty@b4>
Date: Wed, 28 Oct 2026 17:01:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Tue, 13 Oct 2026 16:35:22 +0530, Aswin Murugan wrote:
> This series adds support for exiting Gunyah hypervisor and switching to
> EL2 during early boot on Qualcomm Dragonwing family platforms. This
> enables U-Boot to run at EL2, which is required for supporting
> hypervisors that need EL2 privilege level.
> 
> - Adds early boot0.h infrastructure to exit Gunyah via TrustZone SMC
> - Creates a reusable config fragment for easy platform enablement
> - Enables the feature on QCS9100 platform
> 
> [...]

Applied, thanks!

[1/3] mach-snapdragon: Add early EL2 hypervisor switch support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/b7b422115ca5
[2/3] configs: qualcomm: Add Gunyah exit config fragment
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f477e5d17ff9
[3/3] configs: qcom_qcs9100: Enable Gunyah exit support
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/a9907919a380

Best regards,
-- 
// Casey (she/they)


