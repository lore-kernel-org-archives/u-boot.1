Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7469606A332
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GpU0Y6yU;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=DNw+mwl7
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65E29408EE;
	Tue, 17 Nov 2026 20:03:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PIn8huUlenEb; Tue, 17 Nov 2026 20:03:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BB67C409BB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794945791;
	b=tZz74yce71mWEFDu/5VtqMAFFtePKJRwXRBRy2f/BFHio7scQXsgn5/ZVXMCa5rTd4QP
	 DShalz+qJ0AayUoHIttRaqOFf7LFGQGB6dx7hEWlwdL8iY2dEkAR+uaub/biBif7imLBn
	 oW1Pkc7OeJyczvTvuCowq+emHbPz16l2wjRK3XkNlsMPNVq8ubuPrrS9gYxTttyV1ggKN
	 gwLZuGOPUZvY+CAyK2ktitzZjXzCN6UWrmWJTab25S8IG/thdXk5hVZlU8ValeKYlT+Re
	 irB7JrUTNc5mkwOOb7xyPpaJlcd8nbbukjJhDIjb0q/K0YynLRWppCftCriCBm+520A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794945791;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9kbo6xDFQKvwT8HtOPnq+fBz2Z0Qrm03PkuQTrxfWJk=;
	b=QQ+AqhCWs1jaIdha62FuAnElasqrXR3KQiUeRSfSNxK5jcI92+CjGkiF2TKl/pLjkhms
	 BOnNsiXYS3q80qEMvUiSDni3fqMxRFUonHzjhutgIis16Zm/pS8n4pcLfe++tVFeQSqJm
	 Zn1P1k17VArlH/sWgAL4Ci6TjAC1FBRbK7GhL4hui3ggPsYImWSydqop0rXiELzOUbZkq
	 XwLzg8dGV+9m4uyydLhB/ORdKGHSod4YBAMRTzx9lW55QYrCblBb/q/BZ6HdOSQRAH4sL
	 TCawAp503Cc4SxNFis7uEfgaI4QbzCtBY5My4sA9/bnvpedJmFu4AG6XsOSMZAb8NZg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=DNw+mwl7;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794945791;
	bh=9kbo6xDFQKvwT8HtOPnq+fBz2Z0Qrm03PkuQTrxfWJk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GpU0Y6yUIoTJ+yo0Y/eN/lJSBOJ0oVEJoBttqY6eWTDnkg88ZOZoSjWQtABHWyzJI
	 M5fsRcS91Fw66S9KSuPmh21z66wSDdSIQh2PI2DzykXYHkITG610qjWWHmb70QIBmQ
	 hkxswsfmSiWmTA65avJx4oJpva//iMQNgBmbEb/Al3xUMhfz8YB5zlEkUK4Oc13NNt
	 lPCNAH3KREHiCSFYUaIE154jXZSQCOZeEQSja77RoUSBSkPPw8tYY0b55e4g/dnR9J
	 dbb3mhInRjX9A9SyvffalirSxeQKzpnZfpbXziDsmOl8ZJxjgGubQU2Qyng4RDMgkF
	 45B9HHp5tqv3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB67C409BB;
	Tue, 17 Nov 2026 20:03:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D30A49B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AC9640799
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RPoDPEGnGIgp for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 20:03:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A676640785
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=DNw+mwl7
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A676640785
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 20:03:06 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6de2f213b7aso113730eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794945786; x=1795550586;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9kbo6xDFQKvwT8HtOPnq+fBz2Z0Qrm03PkuQTrxfWJk=;
 b=DNw+mwl758fQNX77NdOySwbj23zSW4Zg+Ai4l0aV0jSygd4ZgFrdGPtwzXL0kYpfd3
 90AeVfnMt7Q85kq1IS+cyD4hQWF0n15Rm6YLx1pQBO4Nl13GCFzNYjOMmpf5Xa8D2+yJ
 rrZB4bR7Xk+QAysXnjWnAzANNe275x8X9tA8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794945786; x=1795550586;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9kbo6xDFQKvwT8HtOPnq+fBz2Z0Qrm03PkuQTrxfWJk=;
 b=ZSiZMuAh1JM/YJfMHWZzRbkH5NSsgVyuIPLn3wp3pGRPxrBhSxKDoCTB8uYDI+gG75
 rzbApU1BYiWIjaxtHWpuXrsjE8lghsCEI1e+hxMWPRimjoLCfM73XeM+AN/3Ek7SxDNP
 TTQ2RbO+oWm94rLSlKJTLK4QgUNofDrsUizpFXrO4YAE0SUfkbwAkhVqDydt4qqDbYcy
 oy9p0NRs8OUgivhl9dOvYoKcdD+yt40Dug3nlJJ5aaELY3nk5Z/hLyHIMC5IJ7MQRPKc
 OxrSaMNYc+FILl7fzR8NSxR1DyvNLg0KuQtITuxKD4uxa1CB/m34P124/Uq60FaHov2t
 1ZEw==
X-Forwarded-Encrypted: i=1;
 AL+hErFIzqfk3A0FUUrPD3EIIT3uD6ZB+3OSp+Hjw47rUQbXH55wNbvVKBL70tygJw+DOGAxXYxC1PM=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9kyl7GqyeN5iUOJYuIev2je5w2JxK5D+UAnA47vxBcMfAkSW1G
 XKfdfboZ13YeqjeZXBcLJDUEbvj2onU1PXIZP+I6+6NsbfjrKyqPMCllz2BpRbMGJSRv6r9TzVE
 +r9uk3FQPXA==
X-Gm-Gg: AYBFou3/QQpZ9zcIvjBETEp7o9okCXnS1bOOfrMduT5ZnYfEYyfIJoOaAYZ274uj7yc
 BeAcOEHV8jk5Q88RxPocy5RtRpoVyrn0W5VkJCgfzKxbTyNF87ik6py92wwy5u9jMOfwQ1I33LA
 FpL2nDbg6s0BIEfVZ6pQOkoPvRkkJs9wkHJ9GeMEId3X9YMx2QKH+UOesEje6q3yDmizogIOoST
 3yXtXudUwIyg6576SrGLmF96f3od+OMKzLwvcFuzMIjbqzPbJvNcqo07LT8RhfoAzpAHoyLMbnI
 JrhFiBkD73t9jUGXyA9Eq1S1HR4/x4NJgHRb0sYy+eJyCBA+JLQmTQ4AIQ+1MoA7d3FfZ2ir379
 tUhuU4K3uqiQHgSxzzM7adSvdPzOro2TxPYuZ9TpE73Pr8vw7kQ1uCI1Uus5pYnGIpmBFve8VOU
 C/kumgbtHHNR5DG5HU9pY9Pk1nEVpPfX+dcS6607TdNxkJLwK8JBP4oOYzKfl+swdQ52k4iR0DL
 nH3L7lAfOSfvAqMFDX71EOpuY/hJzjqRt1ZGbgBOvZzNw5ikMYEC6DCctH21DAMQstnBJgLdUCJ
 uNd6LwYTptdJJmnZnhHQVkBr1P0tXM+kf4P2XrPKywYhbVZunXDjlmHEpqQKQv3YFoKgfB6wgnP
 KDXYKaCOkhunnqr4j02dBqNBgkblhZLDNTmDfPz9EaX9Xkyg9TtCgDeKN9Z8v1AvLA/8mM5g9em
 yHaLUFvxt8+CtniYA2/RBBuO89Qcv8ONrJJ8MYZUriPLAgvw4xiBs=
X-Received: by 2002:a05:6820:a501:10b0:71a:f382:62fe with SMTP id
 006d021491bc7-71b184c3e31mr243106eaf.37.1794945785958; 
 Tue, 17 Nov 2026 12:03:05 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74372cb0esm248119fac.3.2026.11.17.12.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 12:03:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>, 
 u-boot@lists.u-boot-project.org, Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20261117155426.2069931-1-pbrobinson@gmail.com>
References: <20261117155426.2069931-1-pbrobinson@gmail.com>
Subject: Re: [PATCH v3 0/1] MAINTAINERS updates
Message-Id: <179494578488.2846501.4213544280576214142.b4-ty@konsulko.com>
Date: Tue, 17 Nov 2026 14:03:04 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 15:54:18 +0000, Peter Robinson wrote:

> With the departure of Simon there's opportunities for new
> people to step up as maintainers if they so desire. If you
> are interested in helping out in this regard feel reach out
> to the PLC (Tom Rini, Neil Armstrong or myself) or other
> exisiting maintainers in the community if you want more
> information about what the role involves.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] Update maintainers and get_maintainer.ignore
      commit: a119a26e01153dfcbd42713f116b8697294957c8
-- 
Tom


