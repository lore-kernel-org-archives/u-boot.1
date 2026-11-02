Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA92606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DFAqDeSm;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j733aR6h
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CDB06075A;
	Mon,  2 Nov 2026 09:51:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L433HpsNoGUz; Mon,  2 Nov 2026 09:51:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F8846076F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613114;
	b=AuZJeQe3LbUDQH/5GwmV6zcUTFqTyBSJFpcr8+iOam7kO3MsAOlaaPo+GmFzdjLiSdWH
	 +QqEGwubMUI7KKzXCXyGFSFVXH8+k9cpgkNBmisM5txIoYi5Jets4WpkGh0SMtkTwPtvi
	 pPFS/7XjF4gixo6pe8MQSNJk3mIFLlj+iuwcmWUpmghGGGQgILeeAL/TPnp92JUothxoe
	 bZ42JaJisQVIUqcwsCcq5Xu8j5MLeYZzJxGViCTBoUhA9YhkyG2REh5HW8lM9CQ3T0Ojf
	 ywPRUiMV9VJhauxGzTz4CXsD6u1HbhXz02XFSdGb2W8XN2fIUiPcVN3v8i19/3Gkt4A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793613114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kj/OGUdM0Xe7GDKiIzXUG96tbawOuMRVx5pLsri3gBU=;
	b=gMpbF0yiCpnaO3leNJt2OMt+keywoEeSTQ1tMTRspSUpf8VQ0HQeKo8E8N9zEl+q6YRi
	 PfaFuOq55EVdefD9V9wYkWxasukEOxzaEIKUX9gcZY9+Wyjn44RihdTYFKGyDSxG45Fwd
	 m4sgEpXwH+it1tt3MbpbfUbjVnyb1Vfp2dKaGiIP68UpwZmXNIRL/Mf8BpuG/zFg139D9
	 LOcOWgB5i+YZw9kRcGBvvBpbk++/+rhG4MshObjpSiHi4NKJ/fK9FMjLrKcvKLIe4ZOum
	 iAOYHaLYIh/oklDsQUjga/yN/gZSzykjpo+pVp5lewOfbrzRhbZgIBSTEXpjnNIctxw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j733aR6h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793613114;
	bh=kj/OGUdM0Xe7GDKiIzXUG96tbawOuMRVx5pLsri3gBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DFAqDeSmpX0rAbwgWWIlJd3Myf8OgqlpBLL8bDEhvJ2Z/uIRC6mZiPhLseURtzcVF
	 be3742dwcQvy0FNrIXYJdczlZKPQOakilhMreGBoQZIb4ZMDWpoST9rEZEdhcsSnkS
	 tr9z8e6In9GwJnN5i/Wg89KUk+imOLRhZ968Ailfjn2XP7Lr012F+V9XvNDrN1LxzO
	 NJlJoWIQLHOoS3OPBLjgQk5FjayTaYSOibPw779lt5/7c06uy5q72f069OvFLJEPYA
	 hQNsz+C//9xFSlVQlZTHHk34clT472L327VgyqAHEQ60A/HODRxOfY/RhlSHdrMQkg
	 SXAJX+JuKiUuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F8846076F;
	Mon,  2 Nov 2026 09:51:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 45A5C4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B6376076C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:51:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DmQZ6OtnIaA1 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 09:51:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ECE4260600
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1131"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793613112;
 b=lk5Ev5hF0NmuTnTiSad0GxR1DtAPUBw7RayjI5Vg/BIs7/AxFvghY5hSkQjYhpDyTKoN
 J+7CswGZxuDEOtYDqkwZjxigk4D5EtSIIOBXFplNSJSS5YhyfdiYr+lOkEyf7NqNsPW7/
 x3HB2CBynvvw0w4VHB5EbZl+xKeRW9gBqmNX0bp0mPFRMoIDf1l0MXJHnsClMoZi+IhKf
 jtwfYL6KANEs6DCcRyq8MWugbBin/MEC4VJNgbo0oUUBs9T7ruwAowXteGT++YBpx0n2x
 mgVnIULEFRqFWGUFL1Lnzl2i9q2rolwiXRe8RxMCvznIYq/7sLU/jzKQESGcqA/MWJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793613112;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=kj/OGUdM0Xe7GDKiIzXUG96tbawOuMRVx5pLsri3gBU=;
 b=cpZHgVIK1o8SeonSHpaaCr9Z25chQZvlFQPc+mdZltDqxbtmsbxLGTRuZ+VyfcUtn2Bp
 Pj5FxIv6AtsanwRm9afqLUNDKxuqaoO/cuk0PlpbJaNJVcNRIM7NdMwQpRMLIQjs0H8db
 PK0dIVcGwITQQ5RMCD9sqjqAnOEEbXHBN9kGCcwDj4V1v+AEbA7bi/+i/nvDi7qyyBrH8
 haLOGy3cYTfAAm6Mhjk8H2D4XuqDatmAC36nzPw1zLZ2MdG2YyGWy4CsbVrf4tUDmnxh5
 iM7NXtUErgbbl3e5OhAis1kmo5CMMqYuASoAMmMJd3MtU3AhYs7fxxUqhC284/KITDQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=j733aR6h; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1131; helo=mail-yw1-x1131.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=j733aR6h
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ECE4260600
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 09:51:51 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-8aea7b7ca0cso23165917b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 01:51:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793613110; cv=none;
 d=google.com; s=arc-20260327;
 b=ZRr/ut8qGetcUVZztilDnkMyr/5fDTaQe/KwRRLF65dYHd582sbTqCelobQKrFiKkd
 aeLneatBFR5Mw9Kbsw9z/Elb6FSnsxknkyQ1Xdm3p15wjmMgFJUUjMVDkh8bgqVWh0E/
 o02GIGn9n9y0dqUurNc00GCYYLdHMTrqhsXAVZXXmxEX9xOK5C56Y8oCfiUJVHJ2JVgC
 g9+UBCewj+AhANAOjoa+19rOzGc9ocrbqZMdN2KF7cRbTG3aWM4LwammqL4L9aAWrZCP
 B+Q5OqE0bd10NA8R5ojndchtcUXJ6bG+auXqidVyjYrTIK4Z+stIfIF0qj3nLePlkNV4
 XPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=kj/OGUdM0Xe7GDKiIzXUG96tbawOuMRVx5pLsri3gBU=;
 fh=LMDTxfLuF3GHDvIdX1CbNdBeJkvqDQixFqhZJe+DNeU=;
 b=H2P4rRBAqQJF5rTnXXmlQBsXU9oMcuqHE/sQZNvtjwfi9iIK95qvSkUt8m5ecjJSUG
 QruM/52WcQMyYKGI3r6H1JQZTYLqBK0TMvKdZ22QIaOlakA3tKOqrhoBujzYoPzxsf0n
 u6cblsw5FtrVEC1fqKOQZRUH92tir40hkC3t0/ifME1nr0yyu7yepFtgdCiKb+ds+43V
 iyI3CsxxeeB6EdoKrF1QpMifcXH41Q1hpSzHhIqtA+hcka2Eb9cm4yFNJz8TtQv9dwJA
 MIlU4jb/zacxJEinTHKGOTF+4ewxKZm4+VF9J7o0f10M8pnitd3SCiHUAYG5iEXA54R8
 2G7A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793613110; x=1794217910;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kj/OGUdM0Xe7GDKiIzXUG96tbawOuMRVx5pLsri3gBU=;
 b=j733aR6hy3PJE2xH1tpBDehynj+ZGPIzyMPvgE9e3hChm8DcYYT0qxjvJDmJMpgD79
 eS+Z49mS55gwbs+hohqKYOlrjywOr/kwIKs5RxJzzzm4bOAsoQlt0KezYEq7TR1qvWdz
 Qttc3Qcryv5nb1hLNgj3AWDKsFh9selzfJGhxFyi8V9sTFlD6OoNOyKjixBLIb7xA/P+
 qnS4PtALnt66ok+rgnA6TM6KyouZ+j7IHtr8p+qSVIlqZkiSG6mj4QcCjSzxNU1fLC8O
 /7INNxzSeqLQspAXpgxH8jUY4l6gbTDfhWy8AKZzs30sec+6qRp6nou8Dpwmq+DZqNOl
 bzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793613110; x=1794217910;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kj/OGUdM0Xe7GDKiIzXUG96tbawOuMRVx5pLsri3gBU=;
 b=NRCwarqz0X/gdo8XkwZDGfku2HVEiM0hrcJV5L4OeH1/xzM9KLMwuvR/0YSNvePGMK
 gfJcaJtwFFSCnDoolg8GTSqcOWqbWCUzZU1CqS/dVztjOYOyaoBaw9CuLWvWA+owvE7t
 n4qSs7Nqu4Ltph5JHEH+71iZb93ADSv+w3/Nk9uDz7Vm6YMid7FynZZ1ika5R6G/IH7t
 m2gPbtQmOQ7ho+a/bnNanJ0wFUhdxX7pBhHWS5SL2aCZHnL+RQvOIjX2VxcM0bZpO35E
 UgioP0soL8dU2u1GyfWi0jmu7DQ5wq4uv611KJPlVcJ9laJ+YfU9jQw6zNAMSCWRBjT6
 LR3Q==
X-Gm-Message-State: APuU4Z/YoykZi/EiivuOdTFsfeC0PA692ZHUYaFyDULLlQ+jxMMjoKYv
 uIUt5ua1Wo1rJjwXwDwV30DHnat15Gk5Oa31Ivuez/axVBUnXWTi9VCXY1afQEGSI3z+5Yb/2hk
 Rqni8ScCNclL0wspllUb3a/GChdhAF6Jpcfk5tSEkOis4u4kyvQs9OXY0hA==
X-Gm-Gg: AYBFou3gcxy9+GdP8XZpaYgEJyR4OPBSXDxNyTySsDXfVhefwMbuRBRZdrLg+BEXeLX
 8Au69fWu+K3kW3KbbKVH/6POq4ON+zd2bmSybgMxU9s6YEGZoQa7V7LmBV4+3cRFEcldIAJR1He
 FXrXi5uGwuHx/0xVLX1ac5deL5RjBCk3NGLM3sM38QtjctA2f83lJ1cGaeAs8/TzqkH+mgVu8IG
 WAZ2Q/hjqhTSA6uoF0SYYFyiKFabhg2+rB23RAVhRKazaHS+CyP3dnm0g0fGUD9M+z+7r7XHnmZ
 bnnKtV1lPr97gaoTuFdS/hrVwFEojgl8zGr/UWFMJ42CUA+LmBJ3ArAQjFhpInfjDvfO5/Xqm6f
 cfgq4iahOZkrdnLAAy0Gmk2Rwy5/V3CCB9TyxBjdyqm8oKFyEQ+/doAUMIWqC+79XxwnEDJytjp
 D5nmA7Awdl8NiJEZ2VqSrXayOCDigoED0WjrUGxv4QNAedq2uuvgoseYolOUsHxk0Wnugf+/UA4
 Yavmt1u4YsaY4J+lNPuOhhmW1MxFH6VjMF1tiRTeDysg6YoX4N9NIeMp3KNX5LUzlx9S1MXQLWB
 AeAwhmkdg+V7a+w2AS3WxmcAqq+M90EaOLXcIT4WbrlO5bhpQ/e+HLjlF9YxneJa8da7AsffBBx
 39pFxZtxf7AFYMXGMc24ucMBIZJpHFO+I9I5F05c7L9ACflhDp4gNOkw4uP7f4CnEMtLjFt0SgV
 fbzg9QBG41pvdT2q2i2eZuzd6Ui0CvCOnf3kFDBPwx2Vawi9KklVGFP2rZ
X-Received: by 2002:a05:690c:7013:b0:8b1:46a1:28a0 with SMTP id
 00721157ae682-8b2b65b9e96mr58783397b3.6.1793613110055; Mon, 02 Nov 2026
 01:51:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029150906.1558380-1-tkirchner@emlix.com>
 <20261029150906.1558380-5-tkirchner@emlix.com>
In-Reply-To: <20261029150906.1558380-5-tkirchner@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 2 Nov 2026 11:51:14 +0200
X-Gm-Features: AclHuK9aXWFopBkmuuc7d7vuBhLTAFvxmBY7uw2dP9Dmz3Z1-IIzm4ak1h4sK08
Message-ID: <CAC_iWjLB1BSpmtOrR4S48mvCyJgt7UjgpTzpS=dPWZq7wN4_wA@mail.gmail.com>
Subject: Re: [PATCH 4/5] tpm: deactivate only unsupported banks before PCR
 extend
To: Tycho Kirchner <tkirchner@emlix.com>, Raymond Mao <raymondmaoca@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 at 17:09, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> Commit e7e166dabf12 ("tpm: PCR allocate during PCR extend to disable
> the unsupported algorithms") intends to deactivate active banks with
> unsupported algorithms when extending a PCR. However, it calls
> tpm2_pcr_allocate() with an algorithm mask of 0, which deactivates
> *all* banks, including the supported ones:
>
>   set bank[0] sha1 off
>   set bank[1] sha256 off
>   ...
>
> If the TPM refuses this allocation, nothing changes, and the same
> happens again on every boot. If the TPM accepts it, no bank is active
> after the next TPM2_Startup, so nothing can be measured on any later
> boot either. Moreover, the allocation is changed regardless of
> CONFIG_TPM_PCR_ALLOCATE.
>
> Instead, if CONFIG_TPM_PCR_ALLOCATE is enabled, call
> tpm2_activate_banks(), which keeps the supported active banks,
> deactivates the others and resets the board. Otherwise, leave the
> allocation untouched. In both cases, the extend fails while unsupported
> banks are active

This makes sense.  Raymond do you remember why tpm2_pcr_allocate() was called?


Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>
> Fixes: e7e166dabf12 ("tpm: PCR allocate during PCR extend to disable the unsupported algorithms")
> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
> ---
>  lib/tpm-v2.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index b727c645d73..18ec9eb960d 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -362,9 +362,15 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
>         if (!tpm2_check_active_banks(dev)) {
>                 log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
>
> -               ret = tpm2_pcr_allocate(dev, 0);
> -               if (ret)
> -                       return -EINVAL;
> +               /*
> +                * Deactivate the unsupported banks. On success this resets
> +                * the board, since the new allocation only takes effect after
> +                * the next TPM2_Startup.
> +                */
> +               if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE))
> +                       tpm2_activate_banks(dev, 0);
> +
> +               return -EINVAL;
>         }
>         /*
>          * Fill the command structure starting from the first buffer:
> --
> 2.47.3
>
