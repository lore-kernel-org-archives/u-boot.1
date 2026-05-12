Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BD9CD4F26
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 08:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0702F80398;
	Tue, 12 May 2026 10:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernkonzept.com header.i=@kernkonzept.com header.b="Zdfg5ALT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E79B801A9; Tue, 12 May 2026 10:44:53 +0200 (CEST)
Received: from mx.kernkonzept.com (serv1.kernkonzept.com
 [IPv6:2a01:4f8:1c1c:b490::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E8AB83015
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=kernkonzept.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=christian.poetzsch@kernkonzept.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
 Reply-To:Content-ID:Content-Description;
 bh=lfQNz6xqz7rWvTlAfUeap6WP9jEmtEub7b7z0Szjq/w=; b=Zdfg5ALTX+aOcwQqqTxmMmGGol
 xaMzpzb2fJEBodDyBC2y5pnUmh0KHYmeMkHGmsJ5Sh8TDySMfhA+NlcY+ERJmONJuxJ+8go7GXiPa
 L/FjOlCRZG3jNjgF4+IIJ4MvsTjJM4w+FtDI/hWtzYo9e5e6H8tSKBreYmEqUlXPdvvJn6Xm7zRkG
 KuxpK1X1bAlGutLAnpwfs4esiv+/Xq+jk14fj52AG50yGDK0GUXnBPPZu0HcRdGdGIEWluyQrt+MA
 S6d/G0nPJekQLZVsBrbfUehTzmyERt7loUlhvnt1b1WLM1oB7ttzzpJUYqN6UdYSEJ4biRw/UoJ2g
 /UqjyZtg==;
Received: from [10.22.3.169] by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim 4.98.2)
 id 1wMijR-0000000AwUH-2RC9; Tue, 12 May 2026 10:44:49 +0200
Message-ID: <f3298612-fea3-4669-9264-03af727b436a@kernkonzept.com>
Date: Tue, 12 May 2026 10:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260428140433.GQ41863@bill-the-cat>
Content-Language: en-US
From: =?UTF-8?Q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Autocrypt: addr=christian.poetzsch@kernkonzept.com; keydata=
 xsFNBGO+lL4BEADvVOBlrqgAywiCFI4ib96Azgiwa8AQiY5zh3flASjoPNkrhb7Piq51ULVQ
 32v9GuUqqJ5LqhJ3nigDhnCfy1XMLrGeidZ0+WVUDcjTQtyXrUtFHYEPw7WysT7gcBAD0OpY
 aqq1Sb7iSt8ldpPIxy1QSbJRC4LMwRby5m4hry7VVxrwzSzRlFtT6KP89QV230hOBjk0xfHe
 7EyHF0oicgZWM4BIE2zpVmQz+oQMmQxdz7Tld5ctPMFqemGZ/gxfsGXpdc9gZ1bAhJ08XdV7
 yltXDnN2mx3iU5DiyE9N50t1YcMiKsq6QjA/VDb2A+4C7tSEUr4JMXZfPGRYWS9gdc19010z
 co9yiePysAwC8C66k0CDhcCr2BDprqze+psvgOc6y4bhGuMwdVg08A0ykXDBRNOfj6RRG8jl
 OasnzttHOaZcZFMUZsM5f4Mbb2GqXFHRGMNn1D1595HH/lgnjFTLBDCSxI10jJUpG00hHaZG
 sRE1cFhXyXVw//OyOk89D3nylbM9oTSuF+pwvLHjtCzQJnmOWvl5EKQPzWL6IeD7PetuNmfG
 KMMHjOzQpwi5HPYSgcnawDdFnDYkBQU9pacgZHDF9v0g0WyOkxyrpPd5k4f4ELxPRp3b+6Ik
 D/e8qARDX9CVpuV9s8YGdyoVzCoIy6t242oyf0gPhDZoAjQoBwARAQABzTdDaHJpc3RpYW4g
 UMO2dHpzY2ggPGNocmlzdGlhbi5wb2V0enNjaEBrZXJua29uemVwdC5jb20+wsGOBBMBCgA4
 FiEEfBdKi2Mou/zrTV2fH0HKfDw9zhcFAmO+lL4CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgEC
 F4AACgkQH0HKfDw9zhcktw/+N7gIWIogmWkLSWB9lb3OKe/oTrlGAw4nLfwiREwUSMxHYlXD
 gAe4N0LO1F8RJUOeMAWRFc9ZOqSDbQ6R9K5ABXN7mX6e/AdMlgAyC90FxQB39SUxkKgnYmYB
 AxwAQAv9Yw0FGHUYoGhUSI4m6a4up3E9iT7yoov7+26X+kdAnVNtSOJCV+MzqqCpYhP2bDtx
 Ix/Y0cMJRSm0ZxFxUgF+6cXJzFh/f1AQzSr0oP2DWMpkylyGopeGYNp8fbulLoe1JS3EOcMe
 xmv0eF3SVK/J2viHaVKzJgnbg1R2ATOEQh6yHEwcpnsrrLQzzqhmfizrZtYqB/4zhRvzEPLG
 XnQP/0L3++gcFJBfuWT1Xicp7nSRBn4HyGNjKgHdwV/119TL3Qw6Rr8638ZP7LFciEjhtY+t
 gVPtufUzZUJwImZoRzua/naxDmfwBYzqiW0bP60T1Obw/kAZWcb2hNovD2BApBjg31Htdfx/
 H2ssIcmWjfL+zHFu7lUr9ASyZ1mifDCkZYzrrheiOuizwqxuaMSVv4rpwfe3Ii0xdv3zkaSJ
 N7It6geCnVBH9wtBlp7y2BRnX5AUIWFHqYttX2lsH78+qf+pzBVTxtDr+ayxV/XLLqNiGm2n
 mVATVKbFoWy05RApM6BNWS7pf88Ur1Y++0kPM0iw7VoqkCPUKGcfDmpKZuXOwU0EY76UvgEQ
 ALPwrZWdELTuMZpdPxRHXAd5TDBr2sLAx8dJDTeL4LgaPdobEFvPG1UOa9qWLij3K1XP0z43
 W1xQjYhcMmLmXTLiBAP6jTkMcmEdUAHO1AbaxwniZnUD+unVsY9V08rAITuA97TGJgsP59jR
 S6lsMighksWeKS6iG56C7r+EjywWU3z7LPUTuUbr361KDCWG1ZNupT0WG2118yaJSHkpJtl5
 Hjp9Fl0aprM3wwgsfMtbuY0ClM8V+68VLpjiqUO4o7emRpNm0x5idb3FFblAQ6XtuSS/vJ4s
 4PeMxUz6h0oc/C6Gq7JWz4v8bciEPtvbbS7gOR2mRajOiO6M3TaIqvFW7QqtUQjy5Ak/S01m
 2g9tpo7yOzLfE34rpmGAHRgnrJ+UC91Yd+v/nrQyyne/l+OMpmxyNqGMt+WxnlQP68ze4zR+
 T5YdyXEoqB438WZWg/17MpjnwlAJ49mVV/zTCF8jfiDcwTsrc1dQ5hky/fUyM0fbvlFr9TTi
 cpCsfqLfArlJdEXMf6HtodsyQ/ICib2Qczmzkm3xRBQTOzMDH4XZuiMkNLpeUaoF7Vd6wHOf
 ZLON/IL5dGpeOKfIBCTUD47rNUL2g8rPgrqjgvETVwMq62g4P/t0NwdPphkpWDcxMUfHOBaM
 uh/YESWe7e5B2dY+adewbr0vR1fu2Xbnz89fABEBAAHCwXYEGAEKACAWIQR8F0qLYyi7/OtN
 XZ8fQcp8PD3OFwUCY76UvgIbDAAKCRAfQcp8PD3OF7dPD/9uBkB0/++aEeoVCK7IWi2keVXD
 od/rE/IgDTv3+TlFcGU2RvKkXoI0YKbkixYOZUL04hzZjUBXVBGHwugdUmIBGApMgmu9W/vT
 WEmOsGbxx4BsgrgCKQIHzShUQy9GU6WgzZwo6qsoJ3BO7nroxwjGSZm1bZYqmeXSbCEl1dPP
 j4cdFxyeLPII5B4OZtX5QRkmmSycevYldFWi3/r3uJbs6ewxoNJUWTvxQjzqbfdtJJlYOiGx
 9KY+Gbq9J0I/g1ZE/mV4nmNeSroqp9cczjqNpQ0aPCNv5fpbJ/bkfoXJ+y6uC/83nwr6bH2Z
 pGf/ZPwrt5ObPTCUp2vYN9mofFA5K1LGVyLk4u1OnNat8CJv0yCUeM9p+VxvecgkhX2CiQV5
 Zj3pqsxW+PuzUDbTtqtiSz/BBkqtvVmYl8BrMSqmJgNVQAJbGlmom7LxkOeETc1Fy4oeIhJh
 MJSkC6NtmEhVs1z5NtxV3u1qzWp+04pMGUoQ+fCr+3PEuHhNSmuajmvSXOKDHItTZq+yJL2L
 kCip7ctJCSnUy/Z4bmYSL9ByJyoXavBkvgKJtxkuLmofN7+M9M2Bet1+ovf/OMl8wmoQYTF1
 pRSDMY9QKJ8t7R7NdJwed8TiScweaJXLDeclK5sDl56+gdAXb+XA6xsEmqv2qySRekIk8vtG
 T5WSo993xA==
In-Reply-To: <20260428140433.GQ41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

On 4/28/26 4:04 PM, Tom Rini wrote:
> Here's the latest report.
> 
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Mon, Apr 27, 2026, 5:41 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> 
> 
> Hi,
> 
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
> 
>     - *New Defects Found:* 9
>     - 77 defect(s), reported by Coverity Scan earlier, were marked fixed in
>     the recent build analyzed by Coverity Scan.
>     - *Defects Shown:* Showing 9 of 9 defect(s)
> 
> Defect Details
> 
> 
> ** CID 645841:       Incorrect expression  (BAD_COMPARE)
> /common/bloblist.c: 303           in bloblist_apply_blobs()
> 
> 
> _____________________________________________________________________________________________
> *** CID 645841:         Incorrect expression  (BAD_COMPARE)
> /common/bloblist.c: 303             in bloblist_apply_blobs()
> 297     				log_err("Failed to apply blob with tag %d\n",
> 298     					tag);
> 299     				return ret;
> 300     			}
> 301
> 302     			rec = rec_from_blob(blob - dat_off);
>>>>      CID 645841:         Incorrect expression  (BAD_COMPARE)
>>>>      Comparing pointer "rec" against "NULL" using anything besides "==" or "!=" is likely to be incorrect.
> 303     			if (rec <= 0) {
> 304     				log_err("Blob corrupted\n");
> 305     				return -ENOENT;
> 306     			}
> 307
> 308     			/* Mark applied blob record as void */
> 
> ** CID 645840:       Uninitialized variables  (UNINIT)
> 
> 
> _____________________________________________________________________________________________
> *** CID 645840:         Uninitialized variables  (UNINIT)
> /lib/efi_loader/efi_device_path.c: 967             in efi_dp_from_http()
> 961     	if ((server && strlen("http://") + strlen(server) + 1  >
> sizeof(tmp)) ||
> 962     	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> 963     		return NULL;
> 964
> 965     	efi_net_get_addr(&ip, &mask, NULL, dev);
> 966
>>>>      CID 645840:         Uninitialized variables  (UNINIT)
>>>>      Using uninitialized value "ip" when calling "efi_dp_from_ipv4".
> 967     	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL, dev);
> 968     	if (!dp1)
> 969     		return NULL;
> 970
> 971
> 972     	strcpy(tmp, "http://");
> 
> ** CID 645839:       Error handling issues  (CHECKED_RETURN)
> /lib/fdtdec.c: 1785           in fdtdec_apply_bloblist_dtos()
> 
> 
> _____________________________________________________________________________________________
> *** CID 645839:         Error handling issues  (CHECKED_RETURN)
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
>>>>      CID 645839:         Error handling issues  (CHECKED_RETURN)
>>>>      Calling "fdt_pack" without checking return value (as is done elsewhere 5 out of 6 times).
> 1785     	fdt_pack(live_fdt);
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 
> ** CID 645838:       Uninitialized variables  (UNINIT)
> 
> 
> _____________________________________________________________________________________________
> *** CID 645838:         Uninitialized variables  (UNINIT)
> /lib/efi_loader/efi_device_path.c: 967             in efi_dp_from_http()
> 961     	if ((server && strlen("http://") + strlen(server) + 1  >
> sizeof(tmp)) ||
> 962     	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
> 963     		return NULL;
> 964
> 965     	efi_net_get_addr(&ip, &mask, NULL, dev);
> 966
>>>>      CID 645838:         Uninitialized variables  (UNINIT)
>>>>      Using uninitialized value "mask" when calling "efi_dp_from_ipv4".
> 967     	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL, dev);
> 968     	if (!dp1)
> 969     		return NULL;
> 970
> 971
> 972     	strcpy(tmp, "http://");
> 
> ** CID 645837:         (TAINTED_SCALAR)
> 
> 
> _____________________________________________________________________________________________
> *** CID 645837:           (TAINTED_SCALAR)
> /lib/fdtdec.c: 1775             in fdtdec_apply_bloblist_dtos()
> 1769     	/* Resize if the current space is not sufficient */
> 1770     	if (blob_size < padded_size) {
> 1771     		ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, padded_size);
> 1772     		if (ret)
> 1773     			return ret;
> 1774
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "live_fdt->size_dt_struct" to "fdt_open_into", which uses it as an offset.
> 1775     		ret = fdt_open_into(live_fdt, live_fdt, padded_size);
> 1776     		if (ret)
> 1777     			return ret;
> 1778     	}
> 1779
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "live_fdt->size_dt_struct" to "fdt_pack", which uses it as an offset.
> 1785     	fdt_pack(live_fdt);
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> /lib/fdtdec.c: 1775             in fdtdec_apply_bloblist_dtos()
> 1769     	/* Resize if the current space is not sufficient */
> 1770     	if (blob_size < padded_size) {
> 1771     		ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, padded_size);
> 1772     		if (ret)
> 1773     			return ret;
> 1774
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "live_fdt->totalsize" to "fdt_open_into", which uses it as an offset.
> 1775     		ret = fdt_open_into(live_fdt, live_fdt, padded_size);
> 1776     		if (ret)
> 1777     			return ret;
> 1778     	}
> 1779
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
> 1785     	fdt_pack(live_fdt);
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "fdt32_ld(&((struct fdt_header const *)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791     	int ret = -ENOENT;
> /lib/fdtdec.c: 1775             in fdtdec_apply_bloblist_dtos()
> 1769     	/* Resize if the current space is not sufficient */
> 1770     	if (blob_size < padded_size) {
> 1771     		ret = bloblist_resize(BLOBLISTT_CONTROL_FDT, padded_size);
> 1772     		if (ret)
> 1773     			return ret;
> 1774
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "live_fdt->size_dt_strings" to "fdt_open_into", which uses it as an offset.
> 1775     		ret = fdt_open_into(live_fdt, live_fdt, padded_size);
> 1776     		if (ret)
> 1777     			return ret;
> 1778     	}
> 1779
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "live_fdt->size_dt_struct" to "fdt_pack", which uses it as an offset.
> 1785     	fdt_pack(live_fdt);
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
> 1785     	fdt_pack(live_fdt);
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "fdt32_ld(&((struct fdt_header const *)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791     	int ret = -ENOENT;
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "live_fdt->size_dt_strings" to "fdt_pack", which uses it as an offset.
> 1785     	fdt_pack(live_fdt);
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
> 1785     	fdt_pack(live_fdt);
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "fdt32_ld(&((struct fdt_header const *)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791     	int ret = -ENOENT;
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
> 1785     	fdt_pack(live_fdt);
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "fdt32_ld(&((struct fdt_header const *)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791     	int ret = -ENOENT;
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
> 1785     	fdt_pack(live_fdt);
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "fdt32_ld(&((struct fdt_header const *)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791     	int ret = -ENOENT;
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "live_fdt->size_dt_struct" to "fdt_pack", which uses it as an offset.
> 1785     	fdt_pack(live_fdt);
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> /lib/fdtdec.c: 1785             in fdtdec_apply_bloblist_dtos()
> 1779
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "live_fdt->size_dt_strings" to "fdt_pack", which uses it as an offset.
> 1785     	fdt_pack(live_fdt);
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> /lib/fdtdec.c: 1786             in fdtdec_apply_bloblist_dtos()
> 1780     	ret = bloblist_apply_blobs(BLOBLISTT_FDT_OVERLAY,
> fdtdec_apply_dto_blob);
> 1781     	if (ret)
> 1782     		return ret;
> 1783
> 1784     	/* Shink the blob to the actual FDT size */
> 1785     	fdt_pack(live_fdt);
>>>>      CID 645837:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "fdt32_ld(&((struct fdt_header const *)live_fdt)->totalsize)" to "bloblist_resize", which uses it as an offset.
> 1786     	return bloblist_resize(BLOBLISTT_CONTROL_FDT,
> fdt_totalsize(live_fdt));
> 1787     }
> 1788
> 1789     int fdtdec_setup(void)
> 1790     {
> 1791     	int ret = -ENOENT;
> 
> ** CID 645836:       Resource leaks  (RESOURCE_LEAK)
> /drivers/gpio/gpio_scmi.c: 201           in scmi_gpio_probe()
> 
> 
> _____________________________________________________________________________________________
> *** CID 645836:         Resource leaks  (RESOURCE_LEAK)
> /drivers/gpio/gpio_scmi.c: 201             in scmi_gpio_probe()
> 195     			return -ENOMEM;
> 196
> 197     		range->base = args.args[0];
> 198     		if (range->base != priv->num_pins) {
> 199     			dev_err(dev, "no gaps allowed in between pins %d vs %d\n",
> 200     				priv->num_pins, range->base);
>>>>      CID 645836:         Resource leaks  (RESOURCE_LEAK)
>>>>      Variable "range" going out of scope leaks the storage it points to.
> 201     			return -EINVAL;
> 202     		}
> 203     		range->offset = args.args[1];
> 204     		range->npins = args.args[2];
> 205     		priv->num_pins += args.args[2];
> 206     		list_add_tail(&range->list, &priv->gpio_ranges);
> 
> ** CID 645835:       Memory - corruptions  (OVERRUN)
> /lib/gunzip.c: 248           in gzwrite()
> 
> 
> _____________________________________________________________________________________________
> *** CID 645835:         Memory - corruptions  (OVERRUN)
> /lib/gunzip.c: 248             in gzwrite()
> 242     				s.avail_out = szwritebuf - numfilled;
> 243     				s.next_out = writebuf + numfilled;
> 244     			} else {
> 245     				s.avail_out = szwritebuf;
> 246     				s.next_out = writebuf;
> 247     			}
>>>>      CID 645835:         Memory - corruptions  (OVERRUN)
>>>>      Calling "inflate" with "s.next_in" and "s.avail_in" is suspicious because of the very large index, 4294966272. The index may be due to a negative parameter being interpreted as unsigned. [Note: The source code implementation of the function has been overridden by a builtin model.]
> 248     			r = inflate(&s, Z_SYNC_FLUSH);
> 249     			if ((r != Z_OK) &&
> 250     			    (r != Z_STREAM_END)) {
> 251     				printf("Error: inflate() returned %d\n", r);
> 252     				goto out;
> 253     			}
> 
> ** CID 645834:       Control flow issues  (NO_EFFECT)
> /drivers/virtio/virtio_blk.c: 184           in virtio_blk_do_req()
> 
> 
> _____________________________________________________________________________________________
> *** CID 645834:         Control flow issues  (NO_EFFECT)
> /drivers/virtio/virtio_blk.c: 184             in virtio_blk_do_req()
> 178     	*/
> 179     	while (i < blkcnt) {
> 180     		u32 blk_per_sg = min(blkcnt - i, seg_sec_cnt * priv->seg_max);
> 181
> 182     		ret = virtio_blk_do_single_req(dev, sector + i, blk_per_sg,
> 183     					       buffer + i * 512, type);
>>>>      CID 645834:         Control flow issues  (NO_EFFECT)
>>>>      This less-than-zero comparison of an unsigned value is never true. "ret < 0UL".
> 184     		if (ret < 0)
> 185     			return ret;
> 186     		i += blk_per_sg;
> 187     	}
> 188
> 189     	return blkcnt >> priv->blksz_shift;
> 
> ** CID 645833:       Control flow issues  (DEADCODE)
> /drivers/virtio/virtio_blk.c: 185           in virtio_blk_do_req()
> 
> 
> _____________________________________________________________________________________________
> *** CID 645833:         Control flow issues  (DEADCODE)
> /drivers/virtio/virtio_blk.c: 185             in virtio_blk_do_req()
> 179     	while (i < blkcnt) {
> 180     		u32 blk_per_sg = min(blkcnt - i, seg_sec_cnt * priv->seg_max);
> 181
> 182     		ret = virtio_blk_do_single_req(dev, sector + i, blk_per_sg,
> 183     					       buffer + i * 512, type);
> 184     		if (ret < 0)
>>>>      CID 645833:         Control flow issues  (DEADCODE)
>>>>      Execution cannot reach this statement: "return ret;".
> 185     			return ret;
> 186     		i += blk_per_sg;
> 187     	}
> 188
> 189     	return blkcnt >> priv->blksz_shift;
> 190     }
The last two errors should hopefully be fixed by https://patchwork.ozlabs.org/project/uboot/patch/20260512083949.3493010-1-christian.poetzsch@kernkonzept.com/

> 
> 
> 
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=overview>
> 
> Best regards,
> 
> The Coverity Scan Admin Team
> 
> ----- End forwarded message -----
> 

-- 
http://www.kernkonzept.com

Kernkonzept GmbH.  Sitz: Dresden.  Amtsgericht Dresden, HRB 31129.
Geschäftsführer: Dr.-Ing. Michael Hohmuth

