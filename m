Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49119C982D2
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 08:47:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAAAD811F3;
	Fri, 18 Sep 2026 08:47:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2X6F7Zrc4vKe; Fri, 18 Sep 2026 08:47:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 75B9E80EC5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789721263;
	b=PMMOKe7o+r3paCLvRxyMRB+JJmDhk3o785ollB+KAT9CXNeB3et+V4fWsimg/d/wkwZs
	 ot6ukKYeQxwUeRZqNVSej6U58a2zaPnMVSeFple36k7Fk4z3eWRZcyHHC7O3/OqlIpR43
	 VRp/s9qyO+R6HP9s6VWz2K3X/yUEtDoO2r4rZbmd2hswnasEFL/b2/xAJgIOS0w+L48xE
	 8ybgQ9EAynxtiI2s502sbyv+c9q7JfsqkawxUdzUbB67+alShSpmXwrvOm1VPVSZn4ksr
	 jU8KPQnhraK4m5mTwH7GcZCpyg8Payjt5OF9Y/Who10MTl/TbYRSxAZTclJF0aRGaog==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789721263;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=TRA/seGK/UdLaV6cUZLDMaJZd6Y1uLT9xIgZHPw6zEQ=;
	b=hywMTpaQJxahg70n6mZAy5gE5bDWJF8ib8NBfmH51+ln1tB1V4BYwkvBQXhpwjvO8ln3
	 jFd/jWvhKmTAisU0AJW4XeK7Y296Y2lyapYZB72woO5jWgBKi4sps3q+FPpnTBI5X0YdJ
	 jV52ZNd2cyQgEhAQ804Nxlem0/zxxAz5023M/mhYTOm/esU/ICfzPlyad1WkjC056Qdrf
	 deV9M11Rk/yAr2L9EhcTOQhxfltcpqgRAC1yFzXD5MRMPlGvShR4W7+dJH3cpnNZExOwz
	 q4DwkJe7KyTAco+iwafaxzeOSMtsw7NbOqlMefw0XRB2NMypLbLUStO3wLLNDjx4wMA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=OpkbBCjI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789721263;
	bh=TRA/seGK/UdLaV6cUZLDMaJZd6Y1uLT9xIgZHPw6zEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L5ZM/TapXDLGnpaQZ0w5tIOwSxF0/uTa25pcSi9bZcpZ9BejF/gByzYsE3uhuvzHz
	 rTE6CN+YGA2AzOpjLP2s593lISdG4dvNmavsmJqaUWEHn93IfG6Tq1M9AHWdvOhuHX
	 K70tsMoEj1LK/YnPaR3tJU2EhWWrQZMeF430tIDEGdWYyvNDozWTtSz1qquoi0U3fO
	 GAMyWZ8PAVZbNTukTeqQEPAAA6cit5QHG1Xw7LFdhHuO2F+mYls40Iqsmp6m2GELC3
	 FJZc6lMaNcOeHF/4D83ASzkx3FKcH41WpP1w/tbOT/YqUh7GKUu5cT7kjgRA/pQhn0
	 dVl2Ae5bPG1Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75B9E80EC5;
	Fri, 18 Sep 2026 08:47:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 698B137A
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:47:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4EF8D80F00
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:47:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id by2Ba0gxMgoW for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 08:47:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9F5938121F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::11"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789721257;
 b=FN6oJVOJhm7oharO29ikN8ZkBjohUHGluIkfQo3i0am/DVWnDyN/0GpwvN4/kmcq2szM
 mHQAPekqZVk9KiihgbYiTdMZ7DxY1EfrwHzJCu84OuefOm6uAj3LdRv3tvWejob0BeWfN
 S9qGk7uxPQZWakYFTiceQngwvat5daEoGlvKZHWtUDZGzHmfIWIMfNkSFrg0pAig17ov8
 ZwuiRG8d8ZTDypYuVigSGUu2zLySJupn0TOPJrgAJf/oiC6BV59J4tsSmniRNY2w0gYnn
 Ivf4lfW9sPnVgEKXYXBBmYbiE7es0DUL/u2xQXLGr3VL3ie6aFIDy+FkNpSLy1AWYwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789721257;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=TRA/seGK/UdLaV6cUZLDMaJZd6Y1uLT9xIgZHPw6zEQ=;
 b=skm8KHIS+YJiXWzxWluOs40k4SqQaRxbYPSaObDHKmgKl8eExcJf4P8sfjBkBghWxls1
 m0huDLhc+Ho63OjZZ53lAl5cdRwLj0CgIayXSDJ3GgKAzMVUneb9sc3kiKkPHuvG+Tu+5
 FHLIOdx9ImVPp25Ys1KVB4QismR6TTU/1DyGhNelj+5HzAUiG2b/r0aIxwMDq2EHx+pNP
 avY7MqbXI9/wfAZGkdJxZ8N7durV0Ntw6wMIKwHkZrHs9V2ffuQ8qp3nqYzt8q0bq+hx8
 Myxz9dGJ3B2/r/ZRVRYdUq+l4Y+mqwKOYgpd0FdSwa7UUU5ZIBxDTe8KEZJmwWQJkJg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OpkbBCjI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::11; helo=mail-yx2-x11.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=OpkbBCjI
Received: from mail-yx2-x11.google.com (mail-yx2-x11.google.com
 [IPv6:2607:f8b0:4864:41::11])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F5938121F
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 08:47:35 +0000 (UTC)
Received: by mail-yx2-x11.google.com with SMTP id
 956f58d0204a3-66e4aa8d882so559949d50.0
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 01:47:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789721254; cv=none;
 d=google.com; s=arc-20260327;
 b=KMa8TvrZDKy4c8dkcgkIC5+VD7YlIEIh6rZ3S+KO6e3f0FolXcw3Sz9MJ8ujXN4IHn
 Ql7ndwYsXb8cNGectXAUwqcjhtzs/wdqxEO5OjOsZ1oBcLR0wpodwSP1HpUIdimw7pn0
 p29KZr1Z93xvrWsV0ByR9dTdrNKBnSRvNn41rU59Ygto8pSqDQNRHPWnZCtbSaO7GMHy
 KfbtEkNia9zYeUxJtLBI5K5RPnMeJTEfcENeBIuTJLe6Q47hzAjiywA2z6vKkBi4RF1Z
 VUl/jzCMyvfStWd3apiPu+c6Uoe7ciQ1SMSqJGBslsyKYqc+h6qSdnDDy7Klbyc5bpj3
 rHLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TRA/seGK/UdLaV6cUZLDMaJZd6Y1uLT9xIgZHPw6zEQ=;
 fh=E56GXUvROS4erIjE0nASFnNcll1+0KsHxpcC+NkpnZs=;
 b=PbMIA5i/qXo/yC3haFhi1wT1et5LQSqIdInPawgFJ8BpzTVlWIZGbe3yJawP0oKsL9
 oGlH1IgRZEoN8Fnmr5uEmDQ14zbRlrgPa5SZRTrTbxWiVOQvPighblE4vZswhRIVV09p
 Gerq+YcVupcEnb1/RFq1s6ZNTP7W2iuj5s4lFouNhnfdL9A/ejo689bKc3thTmhIJDxf
 skX4WoIz8ivQtOlXOUfpUxvQ6pMtNEdIbQ/GzB+isiFzeUfZf3bGhqOvLKi2lUAmMUhM
 +8a75PQX6W/976MzFs1FcN9Vrn08rDks6IN9qpfrBLqcIeujHI6F2njt4pmBul3QPj20
 WXNQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789721254; x=1790326054;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TRA/seGK/UdLaV6cUZLDMaJZd6Y1uLT9xIgZHPw6zEQ=;
 b=OpkbBCjIbTWA8m9NGLJwdGjfqKY8BumAqE4eIysTX7Z966HSnr4Uk955vLNBce1dzL
 ASOmWJ0VvSdzTPRWvaxITGLalOfsQSGmZAtwOfyuw/87S2+0O0xIDrZQQWu0PdhQlnFb
 kLEnN7aH07biKaa6pg6laQ1XN3BmgvcH2qvvw0xqUDkP+cYPIRvYE73yaLHadSJZBIKD
 Rg8/Zv+h9Wze4TU7k5CzGlmJLC8ZpaAPBRWg+8G6Mh+ZpBmvgudcsSB/zLoiPr86Dr55
 gfuhQFJiDE8fZREjJtYp9ZRBNMmUUB7R/IdgLpU3WwyukQIgl8xTrr4IgZ+cluaVHp7C
 ISag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789721254; x=1790326054;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TRA/seGK/UdLaV6cUZLDMaJZd6Y1uLT9xIgZHPw6zEQ=;
 b=E7hX6h4hcEUqR2AFinP06bLYZP4Q0I2FZ3RR682cdStL8bPuQ0kOiaRjOwvSDbB10X
 PKilLPxLKMWwythTy2d3cla7aDVE6rHrY0cGU6tiSx92FSLTLhKUSFCzal3XHjrt4/RZ
 Ah9N42rBdTW+2gc9Y4kP955Be68jPpAD++XLKpiMHoRNryNmDPVO2odUTzuQJwlTXa9r
 lHdeeEMpk1+ifTckS0RBIaPZ68Oe1mDew4tw1yba4kyGYmzxLNI5j+unfH48zsMoEiTk
 yo918MDrJx45VkgB3sfAwzDxreYLWCbd9oTOHPLAzkOoYIds3t3AOCM2jtks+EIj7P/o
 C8jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxEBAvKTx/f6XL4RT7dL4DG6kKr66wGMudcQ7eE8o4szcTcaRGFpwQZrqvQ3EkIauO8p4nnB08=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kAU+xE5DBKdbk3rIqTMvlzpwlztwRC7gBuedB7LBsTEvTznyXF
 qrrHqN1ny6Q+Gil1aqfOt8C4RZq3JKU7E3VGNkW0i200X2auy45DtwwcdOD1hUBsAAlbXkPY6t9
 whlW2hEDPfyqn+9JR2aUfT7WmLBq1GNhK9GXYl3TbpYaKJECiomfHqUZe8vlh
X-Gm-Gg: AYBFou0CInYcsBoC5BQok8ATaMhdv9sSWUuteVAwVdcoI/klN8VbJF+48I/isYZ/bWF
 Z1eLShFMSlbReDQLwtXRdWfCmBNH46TlQBnoaUwmV4UmWC1zCZrdTFhUlfWTjO0EPAaGmTbQghV
 FPZA1G4l9O0eF5qX5mALuY8QE9EXvyLnVdUXUpzhEHXiOqo77WJva/Xoe3L+8fM1mDEp8Uhc0p1
 1yXbyyZwaObOAYS0hR5p/bvwfVI8ogtKFdSV6MbCQMnc/DBM9yL4S73H+MRnCu4oVVl0UvK+6Hy
 wSxNsaHPuS8mG+M0wDOas0BSmGcnceu5rgY2IIiL1QLuN2qeOG8q7cayIIB6J17HDCNMcPGt7ak
 ufGpQyvq+vJcjjlK7eseEU+wrgu6fjkzn4GSXefmiBJFMPcO4JfwPcc/FMP8wp8pJlcLk3Xwnyj
 bAXmA8pamk4tWiTU2VlwywyiQFFsB26DJp16Wv6Gm0GkDXlEILhS/f08d3HVudExnqiqwr5kv2D
 9o0yYriWqGJdGyFGRLGX+jmEcsPswi3j5uolwbPpQhocH8h+KjT2G4JltWbDBaERzqVUGaz3j+z
 UV7/ufq9df7bzYLxEuWZ4Z1Gqm8sLX0oouce2pUV5F7iJJJx98RtJHiAPz94IUgcTVo1jsHCiIY
 Ek5DbiwtcrjVj5mvOo8xKYjAWNvCHCGdPHbrBbW7wkHY52trAKeNQFQ==
X-Received: by 2002:a05:690e:a4e:b0:66d:11b0:addd with SMTP id
 956f58d0204a3-6717fccae30mr591614d50.37.1789721254550; Fri, 18 Sep 2026
 01:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260903212215.2331118-1-ravi@prevas.dk>
 <20260903212215.2331118-3-ravi@prevas.dk>
 <87a4pttgch.fsf@kernel.org> <87cxup9p0f.fsf@prevas.dk>
 <871pattxgz.fsf@prevas.dk>
In-Reply-To: <871pattxgz.fsf@prevas.dk>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 18 Sep 2026 11:46:58 +0300
X-Gm-Features: AcwNN1UvjOugkqb_D3_iNXDh5AmfKPdjOjx0B7_5FZVC7Y0gyx7NZkXyVJ5cLe8
Message-ID: <CAC_iWjJ3b6J+khJj2jaiMHyw3VEzK1OiNRP2BNfOGDOTt1ijdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] optee_ta_avb.h: add TA_AVB_CMD_READ_PERSIST_VALUE2
 define
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Rasmus

I had a PR ready, but the CI seems to complain on RPMB read/write tests [0]

Can you have a look?

[0] https://git.u-boot-project.org/u-boot/custodians/u-boot-tpm/-/pipelines/1320

Thanks
/Ilias

On Wed, 16 Sept 2026 at 11:24, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Mon, Sep 07 2026, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> > On Mon, Sep 07 2026, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> >
> >> Hi Rasmus,
> >>
> >> Thank you for the patch.
> >>
> >> On Thu, Sep 03, 2026 at 23:22, Rasmus Villemoes <ravi@prevas.dk> wrote:
> >>
> >>> Add the new TA_AVB_CMD_READ_PERSIST_VALUE2 definition, and synchronize
> >>> the comment for the existing TA_AVB_CMD_READ_PERSIST_VALUE with
> >>> optee-os' ta/avb/include/ta_avb.h.
> >>>
> >>> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> >>
> >> I see that this is not yet merged here:
> >> https://github.com/OP-TEE/optee_os/pull/7959
> >>
> >> I hope there won't be any other changes in optee_os, otherwise we will
> >> have to re-update here again.
> >
> > Indeed. I had hoped/assumed that since Jens gave his Reviewed-by it
> > would be merged soonish. I'll give it a few more days, then ping to see
> > if there's more I need to do.
>
> The optee_os side of this is now merged.
>
> Rasmus
