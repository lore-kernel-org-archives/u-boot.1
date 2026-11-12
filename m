Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51910606A335
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RxY2ibzM;
	dkim=pass (2048-bit key, unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=k+SKM7im
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E0F0812DE;
	Thu, 12 Nov 2026 05:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ua4J6djLkcIS; Thu, 12 Nov 2026 05:15:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2195D814BA
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794460500;
	b=Nu0vUNkg36ME1mhVmBjZ9DohJNlw8fFu7/MgtwpEulmSx5jvo/zAghLwsJURF62Mey7i
	 WJZ1pMYIqCRSCyrhDJZjVFEFRi3iMwhgK+noKrU/lS8ecZ5wdWsbXeSF0KYXycICXbmmJ
	 2m9YfdFKSZa9y+D50h9NKU8EYaJDg0e0Eakgympib+AK6yFOPjPvlYunF3lCQkN+nN0JJ
	 ExOzAMGjMdcSHm7S/TXtofM90snmGDjFjR2HBwAZzEtW2l+U1xNl7vhbQyOIt9yDePm5/
	 tieH9pCL9Tc2zyqx+PYhQ20Z6p64cC+Yqbf8vo6FKIBbw6kl8ZZXlqZxH5fQPjZ8Xyw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794460500;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bUxho5+V7XvXEcrV1ZDU08p259youJJpZV3KZKGebOA=;
	b=dDjIIZawDRJJ3VUWThG7q2DSIm+idkjy6fI06I+ZmmVoAHpHUuAshV2B2rmK0G7hVyAY
	 yLNZ04mSSXC9XcXyJZ9gbzKaKmKdk4uaNdDIpf5BMWsAWQ9gL2D025jWXrKEU2NOToD1v
	 jl47rpqXEcWWoqkDNQM+w2XQOMGjJ4ARIpC9ENaBuo/CGKutnUHy81rqHYgsZRhMKysr9
	 L00xVfg+KohY/ppcMmS5HMxWck7PFOSuYoDVZ6rt7kjbQwpOaGnuRrVKaoGnIcIDWwuMj
	 ElA1DBaoBIaw3/Sd8k5KDPkkbWXEO6TGDTUpI1s57sMz04R6Uv4MGJ0qcna1walY+JQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=freeshell.de;
	dkim=pass header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256 header.s=s2025 header.b=k+SKM7im;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794460500;
	bh=bUxho5+V7XvXEcrV1ZDU08p259youJJpZV3KZKGebOA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RxY2ibzMYEbJLTfP6NpAU4bs1hmMqjzYqj3/St7nSJJGF63EweoW365WZGDKSn3Ir
	 d+BBnauOt1CICxtD1/CfySvtQCURDc2CtrJfWv6v86yobqHLNn1hJEe3XHTFqilOys
	 uGyD07RNKa2QKA39AdETUL2LImKAPIhlaOZV8Alr9vwqxyw8VMisVS8XD+Rw5DtD2l
	 d++sKtnBu0XhD9Zfgj4DlsyZ51gpT8Ak7nylY3H6RwvJp9j/EMVIft/4sps3RCKa4+
	 oa6Eg27DshmL+f5U4EwcaVI6kLyxRYOLbSeaksPeA+mbW7cJe69va0mCBKEyXDS3rS
	 0EO/fLc/DvFjQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2195D814BA;
	Thu, 12 Nov 2026 05:15:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EDEEA2FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF102814BA
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:14:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kuL0iA1tdPlr for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 05:14:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 766FE812DE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.202.128.144
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.202.128.144;
 helo=freeshell.de; envelope-from=e@freeshell.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=freeshell.de header.i=@freeshell.de header.a=rsa-sha256
 header.s=s2025 header.b=k+SKM7im
Received: from freeshell.de (freeshell.de [116.202.128.144])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 766FE812DE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1794460477;
 bh=bUxho5+V7XvXEcrV1ZDU08p259youJJpZV3KZKGebOA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k+SKM7imvCkZKA4fjOVrjc7DtwTpxk3Wlmk3JFRDL/40/6M2qZmiphY03aoiaup37
 VqBF/lPCXKFxLeCip/UjxOY/aL+TcUYlu+SWbtqkXP/SmgK/HQK3fPy9OQgG2XVclB
 uOxmjHmAlY4Ay/PYlvraDMDgP9jmcDVh0ZY06pCto1oIAtEl4b8VzgaO4EpMNU3Enh
 u5jMEaz06zqaDZz4tfqvoh+mfxqp5Vnj9NkSMEIK59Z2Gt5+JjyrcJrlPgIWE4eZ5u
 iibkdU6kL6/ktlD4SenfyuHR0MFVhNQMhOW9iuPKCx5ZJmO3wGrI85MUWiTGi+DX5U
 jhGGzqde0/JFg==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown
 [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0B4A9B22001A;
 Thu, 12 Nov 2026 06:14:36 +0100 (CET)
Message-ID: <c634666c-88e3-452e-86f1-d4e1456d597b@freeshell.de>
Date: Wed, 11 Nov 2026 21:14:29 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFH] Writing a project Code of Conduct
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
References: <20261103172036.GS3309461@bill-the-cat>
 <xhkdbcxsdvux2.fsf@mkorpers-koolstof.csb>
 <b415d946-eda6-4ac8-a8ec-4b00a379effb@gmx.de>
 <cae8d4f7-faa2-43d9-866a-cf2ee5d07efa@freeshell.de>
 <20261111151231.GD255403@bill-the-cat>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20261111151231.GD255403@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 07:12, Tom Rini wrote:
> On Tue, Nov 10, 2026 at 06:54:40PM -0800, E Shattow wrote:
>> On 11/10/26 07:12, Heinrich Schuchardt wrote:
>>> On 11/10/26 11:32, Mattijs Korpershoek wrote:
>>>> Hi Tom,
>>>>
>>>> On Tue, Nov 03, 2026 at 11:20, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>>> Hey all,
>>>>>
>>>>> Getting back on track with project administrative tasks, one thing I
>>>>> have talked about the project needing for some time is a code of
>>>>> conduct. In my mind, the best starting point here is, are there code of
>>>>> conducts in other projects that people use and they feel would be a good
>>>>> example for us to adopt? Thanks!
>>>>
>>>> Have you considered the Contributor Covenant Code of Conduct?
>>>> That's the one Linux uses, see:
>>>> https://docs.kernel.org/process/code-of-conduct.html
>>>>
>>>>>
>>>>> -- 
>>>>> Tom
>>>
>>> https://policies.python.org/python.org/code-of-conduct/
>>> is another reasonable code of conduct.
>>>
>>> Best regards
>>>
>>> Heinrich
>>
>> I observe copyright license violations as kind of status quo for
>> embedded vendors taking U-Boot code and stuffing it into SoC BootROM
>> without adhering to the copyright license terms. Writing down rules for
>> social expectations is not on my radar until the legalese is well sorted
>> out for the code contributions. We must not set impossible expectations
>> on top of undefined parameters.
> 
> I see these as generally two separate issues. A code of conduct is to
> help the community itself grow. It's not a "legal document" of some
> sort. Copyright infringement is another matter and if you have specific
> examples, we should have a separate conversation and involve SFC in it
> as well.
> 

Will do, thank you. I'm pretty sure it gets murky around "A.I." usage
and expectation setting for contributors where copyright is assigned to
companies;  enforcement of copyright is ultimately up to those companies
then not in the interests of individuals. These are areas where I think
a Code of Conduct needs to support a basis of expectation for any
individual contributor's other ... expectations and behaviors. Does that
make any sense?  To me it is just pointless to expect a decorum in
participation if any contributing company is ripping off individual
contributors (who might be obliged to endorse this because it is their
employer).

Then there's the discussion about whether we care or not. The "A.I.
believers" might suggest that we're post-copyright now and let the LLM
usage be directed as responsibly as possible but anyway let it have the
leading role, as well as the leading role in review, and copyright or
intellectual property concerns are just an antiquated inconvenience to
be laundered by "the A.I." as a new original work even when trained on
this vast amount of individual human and maybe regurgitated slop
contributions... from what I've read U-Boot community has voiced that
this is not acceptable. Well, when legal recourse is not well-defined,
what social constructs could be stated to support the undefined legal
basis of conduct?

None of the above to any exclusion of discussion about the social
constructs it's just not something I'm prepared to think about until the
gritty basics are covered;  what's the motivation for instance with any
A.I.-forward corporation to solicit against and enforce copyleft
licenses laundered by their own tech at-scale.

And yeah we should treat each-other as we would wish to be treated
ourselves, use "denylist" clearer in meaning and byte shorter than
"blacklist", etc. I'm not trying to opine that writing it down is good
or bad it's just that I'm unwilling to participate in the social
rules-making stuff until we see what the expectations are for code
contribution itself a little better formalized. I don't expect that has
changed much, there is not any proposal to assign copyright to an entity
that would act on our behalf.

-E
